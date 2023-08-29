
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
  default = [
    "compute.googleapis.com",
    "container.googleapis.com"
  ]
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

locals {
  gke_cluster_config = {
    gke-cluster-1 = {
      "podrange"                = "10.8.0.0/14"
      "servicerange"            = "10.12.0.0/20"
      "enable_private_endpoint" = false
      "create_custom_range"     = true
      "network_name"            = module.network["tf-net"].network_name
      "subnet_name"             = module.network["tf-net"].subnet_name["tf-subnet"]
      "pod_range_name"          = var.tf_subnet_config.tf-subnet.podrange
      "service_range_name"      = var.tf_subnet_config.tf-subnet.servicerange

    }
    gke-cluster-dpv2-pv-endpt = {
      "location"                   = "us-west3-a"
      "master_authorized_networks" = "10.0.0.0/8"

    }
    gke-cluster-dpv2-pub-int-endpt = {
      "location"                = "us-west3-b"
      "master_ipv4_cidr_block"  = "172.16.0.32/28"
      "enable_private_endpoint" = false

    }
    gke-cluster-dpv2-pub-ext-endpt = {
      "location"                = "us-west3-c"
      "master_ipv4_cidr_block"  = ""
      "enable_private_endpoint" = false

    }
  }


}