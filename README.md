# gcp-terraform-plans

Project to manage GCP resources

## Step 0: Prepare Project

we are going to run terraform scripts that need to bind resources together using the following APIs make sure they're enabled.

```shell
# enable services
gcloud services enable cloudresourcemanager.googleapis.com && \
gcloud services enable cloudbilling.googleapis.com && \
gcloud services enable iam.googleapis.com && \
gcloud services enable compute.googleapis.com
```

this has been built to run on cloud shell, some of the scripts expect to be able to run `mkdir`, or other `local_exec` commands

## Step 1: Bootstrap

We need to make a file we the following values and create the admin project/sa etc. We need the following variables in `terrafom.tfvars`. if you have this information skip ahead, to Step 2. 

```shell
cd ./bootstrap
cat > terraform.tfvars <<EOF
org_id="xxxxxxxxx"
folder_id="xxxxxxxx"
billing_account="xxxxxxxxx"
EOF
```

### Bootstrap Helpers 

```shell
# get project and folder info you need
export PROJECT_ID=`gcloud config get-value project`
export PROJECT_NUMBER=`gcloud projects describe $PROJECT_ID --format="value(projectNumber)"`
export FOLDER_ID=`gcloud projects get-ancestors $PROJECT_ID --format json | jq .[1].id | tr -d \"`

echo PROJECT_ID:$PROJECT_ID
echo PROJECT_NUMBER:$PROJECT_NUMBER

# My org name is a domain easy to filter on
export DISPLAY_NAME=XXXXXXXXXXXXXX

# get the organization you need
export ORG_ID=`gcloud organizations list --filter='displayName~'"$DISPLAY_NAME"'' --format=json | jq .[0].name | tr -d \" | awk -F / '{print $2}'`

# get the billing account you need
export BILLING_ACCOUNT=`gcloud beta billing accounts list  --filter='displayName~'"$DISPLAY_NAME"'' --format json | jq .[0].name | tr -d \" | awk -F / '{print $2}'`

echo ORG_ID: $ORG_ID
echo BILLING_ACCOUNT: $BILLING_ACCOUNT
```

now, create `terraform.tfvars` for `bootstrap` terraform modules

```shell
cd bootstrap
cat > terraform.tfvars <<EOF
org_id="$ORG_ID"
folder_id="$FOLDER_ID"
billing_account="$BILLING_ACCOUNT"
EOF
```

### Backend (Optional)

I like to persist the backend state for admin-project as well

```shell
gsutil mb -p $PROJECT_ID gs://$PROJECT_ID-tf-admin

cat > backend.tf <<EOF
terraform {
 backend "gcs" {
   bucket  = "$PROJECT_ID-tf-admin"
   prefix  = "terraform/state"
 }
}
EOF
```

## Step 2: Run Terraform for Bootstrap

Run `terraform init`, then `terraform apply`

it creates `backend_tf` and `terraform_tfvars` which can be used in other other runs.

```
$ tree .
.
├── backend.tf
├── main.tf
├── output
│   ├── backend_tf
│   └── terraform_tfvars
├── terraform.tfvars
└── variables.tf

1 directory, 6 files
```

the `terraform_tfvars` has the following variables set

```
org_ig = (org id inherited from bootstrap)
folder_id = folders/(tf-folder where terraform projects will live)
billing_account = (billing account inherited from bootstrap)
admin_project = (admin project just created)
```

and the `backend_tf` also has the following

```
terraform {
    backend "gcs" {
        bucket  = "(admin project just created)"
        prefix  = "terraform/state"
    }
}
```

### Step 3 Run modules 


```shell
# IMPORTANT VARS NEEDED
cd ../ # root of gcp-terraform-plans

cat > terraform.tfvars <<EOF
org_id="$ORG_ID"
folder_id="$FOLDER_ID"
billing_account="$BILLING_ACCOUNT"
admin_project="$ADMIN_PROJECT"
EOF
```

Run `terraform init`, then `terraform apply`
