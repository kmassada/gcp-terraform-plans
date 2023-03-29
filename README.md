# gcp-terraform-plans

Export the following variables to your environment for use throughout the tutorial.

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

# create a terraform folder inside the folder I control
gcloud resource-manager folders create \
   --display-name="terraform-folder" \
   --folder=$FOLDER_ID

# from now on, will use that folder 
echo old FOLDER_ID:$FOLDER_ID
export FOLDER_ID=`gcloud resource-manager folders list  --folder=$FOLDER_ID --filter='displayName~'"terraform-folder"'' --format json | jq .[0].name | tr -d \" | awk -F / '{print $2}'`
echo new FOLDER_ID:$FOLDER_ID


# USE NEW FOLDER NUMBER, create project
yes | gcloud projects create --name terraform-admin \
  --folder $FOLDER_ID \
  --set-as-default

export ADMIN_PROJECT=`gcloud projects list --filter="parent.id=$FOLDER_ID AND name=terraform-admin" --format json | jq .[0].projectId | tr -d \"`
echo ADMIN_PROJECT: $ADMIN_PROJECT

gcloud beta billing projects link $ADMIN_PROJECT \
  --billing-account $BILLING_ACCOUNT

gcloud config set project $ADMIN_PROJECT

# enable services
gcloud services enable cloudresourcemanager.googleapis.com && \
gcloud services enable cloudbilling.googleapis.com && \
gcloud services enable iam.googleapis.com && \
gcloud services enable compute.googleapis.com
```

## optional [create sa]

INFO: creating a terraform admin account to manage some resources in the future

```shell
# Create admin sa
export ADMIN_SA=terraform-admin-sa
gcloud iam service-accounts create $ADMIN_SA --display-name "Terraform admin account" \
&& sleep 5 && \
export ADMIN_SA_ID=`gcloud iam service-accounts list --format='value(email)' --filter='displayName:Terraform admin account'`

gcloud projects add-iam-policy-binding $ADMIN_PROJECT --member=serviceAccount:$ADMIN_SA_ID --role=roles/viewer
gcloud projects add-iam-policy-binding $ADMIN_PROJECT --member=serviceAccount:$ADMIN_SA_ID --role=roles/storage.admin

# For FOLDER NUMBER
gcloud resource-manager folders add-iam-policy-binding $FOLDER_ID --member serviceAccount:$ADMIN_SA_ID --role roles/resourcemanager.projectCreator
```

## External

```shell
gsutil mb -p $ADMIN_PROJECT gs://$ADMIN_PROJECT

cat > backend.tf <<EOF
terraform {
 backend "gcs" {
   bucket  = "$ADMIN_PROJECT"
   prefix  = "terraform/state"
 }
}
EOF
```

create main.tf with provider config

```shell
cat > main.tf <<EOF
provider "google" {
  region  = "us-west1"
  zone    = "us-west1-a"
}
EOF
```

## Run Terraform

set variables

```shell
# IMPORTANT SET VARS NEEDED

cat > terraform.tfvars <<EOF
org_id="$ORG_ID"
folder_id="$FOLDER_ID"
billing_account="$BILLING_ACCOUNT"
admin_project="$ADMIN_PROJECT"
admin_sa="$ADMIN_SA"
admin_sa_id="$ADMIN_SA_ID"
EOF
```

Run `terraform init`, then `terraform apply`

## Output

once the output is set, print command

```shell
echo gcloud container clusters get-credentials $(terraform output cluster_name) \
  --region $(terraform output cluster_location) \
  --project $(terraform output project_id)
```

ssh and run command's output

```shell
gcloud compute ssh $(terraform output instance_name) \
  --zone $(terraform output instance_zone) \
  --project $(terraform output project_id)
```

inside instance install kubectl

```console
tf-instance:~$ sudo apt-get install kubectl
Reading package lists... Done
Building dependency tree
Reading state information... Done

The following NEW packages will be installed:
  kubectl
0 upgraded, 1 newly installed, 0 to remove and 5 not upgraded.


tf-instance:~$ gcloud container clusters get-credentials pv-cluster-tf --region asia-east1 --project tf-btstrp-xxxxxxx
Fetching cluster endpoint and auth data.
kubeconfig entry generated for pv-cluster-tf.


tf-instance:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                                           READY   STATUS    RESTARTS   AGE
kube-system   event-exporter-v0.2.5-7d99d74cf8-hgc5b                         2/2     Running   0          172m
kube-system   fluentd-gcp-scaler-55bdf597c-fgnxs                             1/1     Running   0          172m
kube-system   fluentd-gcp-v3.1.1-7twwg                                       2/2     Running   0          169m
.....
```
