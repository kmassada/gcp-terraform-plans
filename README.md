# gcp-terraform-plans

This terraform project is going to provision the lab project in the specified folder along with the two networks and 4  GKE clusters.
You can configure how many networks and GKE clusters you can have by modyfying the `variables.tf`. Please see below

## Step 0: Prepare Project

we are going to run terraform scripts that need to bind resources together using the following APIs make sure they're enabled.

```shell
# enable services
gcloud services enable cloudresourcemanager.googleapis.com && \
gcloud services enable cloudbilling.googleapis.com && \
gcloud services enable iam.googleapis.com && \
gcloud services enable compute.googleapis.com
```

## Step 1: Create/specify the storage bucket for you terraform project
 Modify `backend.tf` by specifying your backet where you want to keep the terraform states

  ```conf
  terraform {
    backend "gcs" {
      bucket = "terraform-for-all"
      prefix = "for_labs"
    }
  }
  ```

## Step 2. Customize `variables.tf` for your needs

### The mandatory variables
 - the variable "folder_id"
    Grab the folder id where you want to have your lab project to be created `gcloud projects get-ancestors $PROJECT_ID --format json`

### The optional vaiables
-  creating more GKE clusters
   the minimal configuration you need to specify is the gke cluster name in "locals" section of  `variables.tf`:
   For example to create two clusters `gke-cluster-15` and `acunamatata` with the default configuration your `locals.gke_cluster_config ` section will look like below:
    
    ```conf
    locals {
      gke_cluster_config = {
        gke-cluster-15 = {
        }
        acunamatata = {
        }
      }
    }
   ```

   Please see below the available customization options for gke cluster along wiht the default values that applied if you don't specify them for you cluster

  ```conf
    locals {
      gke_cluster_config = {
        gke-cluster-15 = {
          "podrange"                = "10.8.0.0/14"
          "servicerange"            = "10.12.0.0/20"
          "location"                   = "us-west3"
          "project_id" =  "lab project created by google_project.lab_project.id"
          "service_account_email" = "sa created by module.service-accounts["gke-node-sa"].service_account_email"
          "master_authorized_networks" = ""
          "master_ipv4_cidr_block"  = "172.16.0.0/28"
          "master_global_access_config" = true
          "enable_private_endpoint" = true
          "enable_private_nodes" = true
          "create_custom_range"     = false
          "network_name"            = "tf-gke-net"
          "subnet_name"             = ""
          "pod_range_name"          = ""
          "service_range_name"      = ""
          "dataplane_v2" = "ADVANCED_DATAPATH"

        }
      }
    }
  ```


## Step 3 (optional) create Terraform workspace to reuse the same GCS bucket for several lab environemnts
`terraform workspace new [NAME]`

## Step 4 Run Terraform  to create resources

`terraform init`
`terraform plan`
`terraform apply`
