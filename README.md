# gcp-terraform-plans

Export the following variables to your environment for use throughout the tutorial.

```shell
gcloud organizations list
gcloud beta billing accounts list

export TF_VAR_org_id=YOUR_ORG_ID
export TF_VAR_billing_account=YOUR_BILLING_ACCOUNT_ID
export TF_ADMIN=${USER}-terraform-admin
export TF_CREDS=~/.config/gcloud/${USER}-terraform-admin.json

gcloud projects create ${TF_ADMIN} \
  --organization ${TF_VAR_org_id} \
  --set-as-default

gcloud beta billing projects link ${TF_ADMIN} \
  --billing-account ${TF_VAR_billing_account}

gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
```

## optional [create sa]

```shell
gcloud iam service-accounts create terraform \
  --display-name "Terraform admin account"

gcloud iam service-accounts keys create ${TF_CREDS} \
  --iam-account terraform@${TF_ADMIN}.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding ${TF_ADMIN} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/viewer

gcloud projects add-iam-policy-binding ${TF_ADMIN} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/storage.admin

gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/resourcemanager.projectCreator

gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
  --role roles/billing.user
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
gsutil mb -p ${TF_ADMIN} gs://${TF_ADMIN}

cat > backend.tf <<EOF
terraform {
 backend "gcs" {
   bucket  = "${TF_ADMIN}"
   prefix  = "terraform/state"
   project = "${TF_ADMIN}"
 }
}
EOF
```

create main.tf with provider config

```conf
provider "google" {
  project = "some-project"
  region  = "us-west1"
  zone    = "us-west1-a"
}
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
