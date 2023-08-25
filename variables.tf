
variable "region" {
  default = "us-west1"
}

variable "region_zone" {
  default = "us-west1-a"
}

variable "min_master_version" {
  default = "1.25"
}


variable "folder_id" {
  description = "The ID of the Google Cloud Folder."
  default     = ""
}


variable "api_services" {
  description = "Service APIs to enable."
  type        = list(string)
  default = ["compute.googleapis.com",
  "container.googleapis.com"]
}

variable "admin_sa" {
  description = "Admin ServiceAccount name to manage other Terraform resources."
  default     = ""
}


variable "authorized_networks" {
  description = "Authorized networks CIDRs, used in firewall rules"
  default     = ""
}

variable "networks_config" {
  default = {
    "tf-net" = {
      "auto_create_subnetworks" = false
    },
    "tf-gke-net" = {
      "auto_create_subnetworks" = true
    }
  }

}


variable "tf_subnet_config" {
  default = {
    tf-subnet = {
      "name"          = "tf-subnet"
      "primary_range" = "10.128.0.0/20"
      "podrange"      = "10.8.0.0/14"
      "servicerange"  = "10.12.0.0/20"
    }
  }
}


variable "service_accounts" {
  default = {
    bastion = [
      "roles/monitoring.metricWriter",
      "roles/monitoring.viewer",
      "roles/logging.logWriter",
      "roles/container.developer"
    ],
    gke-node-sa = [
      "roles/container.nodeServiceAccount"
    ]

  }
}
