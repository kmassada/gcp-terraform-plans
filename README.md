# gcp-terraform-plans

Export the following variables to your environment for use throughout the tutorial.

```shell
# get project and folder info you need
export PROJECT_ID=`gcloud config get-value project`
export PROJECT_NUMBER=`gcloud projects describe $PROJECT_ID --format="value(projectNumber)"`
export FOLDER_NUMBER=`gcloud projects get-ancestors $PROJECT_ID --format json | jq .[1].id | tr -d \"`

# My org name is a domain easy to filter on
# export DISPLAY_NAME=XXXXXXXXXXXXXX

# get the organization you need
export ORG_ID=`gcloud organizations list --filter='displayName~'"$DISPLAY_NAME"'' --format=json | jq .[0].name | tr -d \" | awk -F / '{print $2}'`

# get the billing account you need
export BILLING_ACCOUNT=`gcloud beta billing accounts list  --filter='displayName~'"$DISPLAY_NAME"'' --format json | jq .[0].name | tr -d \" | awk -F / '{print $2}'`

# create a terraform folder inside the folder I control
gcloud resource-manager folders create \
   --display-name="terraform-folder" \
   --folder=$FOLDER_NUMBER

# from now on, will use that folder 
export FOLDER_NUMBER=`gcloud resource-manager folders list  --folder=$FOLDER_NUMBER --filter='displayName~'"terraform-folder"'' --format json | jq .[0].name | tr -d \" | awk -F / '{print $2}'`

# USE NEW FOLDER NUMBER, create project
yes | gcloud projects create --name terraform-admin \
  --folder ${FOLDER_NUMBER} \
  --set-as-default

export TF_VAR_admin_project=`gcloud projects list --filter="parent.id=$FOLDER_NUMBER AND name=terraform-admin" --format json | jq .[0].projectId | tr -d \"`

gcloud beta billing projects link ${TF_VAR_admin_project} \
  --billing-account ${BILLING_ACCOUNT}

# set TF_VARs
export TF_VAR_org_id=$ORG_ID
export TF_VAR_folder_id=$FOLDER_NUMBER
export TF_VAR_billing_account=$BILLING_ACCOUNT

gcloud config set project ${TF_VAR_admin_project}

# enable services
gcloud services enable cloudresourcemanager.googleapis.com && \
gcloud services enable cloudbilling.googleapis.com && \
gcloud services enable iam.googleapis.com && \
gcloud services enable compute.googleapis.com
```

## optional [create sa]

```shell
# Create admin sa
export TF_VAR_admin_sa=terraform-admin-sa
gcloud iam service-accounts create $TF_VAR_admin_sa --display-name "Terraform admin account" \
&& sleep 5 && \
export TF_VAR_admin_sa_id=`gcloud iam service-accounts list --format='value(email)' --filter='displayName:Terraform admin account'`

gcloud projects add-iam-policy-binding $TF_VAR_admin_project --member=serviceAccount:${TF_VAR_admin_sa_id} --role=roles/viewer
gcloud projects add-iam-policy-binding $TF_VAR_admin_project --member=serviceAccount:${TF_VAR_admin_sa_id} --role=roles/storage.admin

# For FOLDER NUMBER
gcloud resource-manager folders add-iam-policy-binding $TF_VAR_folder_id --member serviceAccount:${TF_VAR_admin_sa_id} --role roles/resourcemanager.projectCreator
```

## Use existing user

```shell
gcloud auth application-default login
```

use output of path to credentials in terraform.tfvars

```shell
creds="/home/$USER/.config/gcloud/application_default_credentials.json"
```

## External

```shell
gsutil mb -p ${TF_VAR_admin_project} gs://${TF_VAR_admin_project}

cat > backend.tf <<EOF
terraform {
 backend "gcs" {
   bucket  = "${TF_VAR_admin_project}"
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

set variables

```shell
# IMPORTANT
export TF_VAR_org_id=YOUR_ORG_ID_OR_FOLDER
export TF_VAR_billing_account=YOUR_BILLING_ACCOUNT_ID
```

Run `terraform init`, then `terraform apply`

## Output

once the output is set, print command

```shell
echo gcloud container clusters get-credentials $(terraform output cluster_name) \
  --region $(terraform output cluster_region) \
  --project $(terraform output project_id)
```

ssh and run command's output

```shell
gcloud compute ssh $(terraform output jumper_name) \
  --zone $(terraform output jumper_zone) \
  --project $(terraform output project_id)
```

inside jumper install kubectl

```console
jumper-tf:~$ sudo apt-get install kubectl
Reading package lists... Done
Building dependency tree
Reading state information... Done

The following NEW packages will be installed:
  kubectl
0 upgraded, 1 newly installed, 0 to remove and 5 not upgraded.


jumper-tf:~$ gcloud container clusters get-credentials pv-cluster-tf --region asia-east1 --project tf-btstrp-xxxxxxx
Fetching cluster endpoint and auth data.
kubeconfig entry generated for pv-cluster-tf.


jumper-tf:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                                           READY   STATUS    RESTARTS   AGE
kube-system   event-exporter-v0.2.5-7d99d74cf8-hgc5b                         2/2     Running   0          172m
kube-system   fluentd-gcp-scaler-55bdf597c-fgnxs                             1/1     Running   0          172m
kube-system   fluentd-gcp-v3.1.1-7twwg                                       2/2     Running   0          169m
.....
```
