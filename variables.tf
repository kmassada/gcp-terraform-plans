
variable "region" {
  default = "us-west1"
}

variable "region_zone" {
  default = "us-west1-a"
}

variable "min_master_version" {
  default = "1.25"
}

variable "org_id" {
  description = "The ID of the Google Cloud Organization."
}

variable "folder_id" {
  description = "The ID of the Google Cloud Folder."
}

variable "billing_account" {
  description = "The ID of the associated billing account (optional)."
}

variable "admin_project" {
  description = "Admin Project to manage other Terraform resources."
}

variable "admin_sa" {
  description = "Admin ServiceAccount name to manage other Terraform resources."
}

variable "admin_sa_id" {
  description = "Admin ServiceAccount ID to manage other Terraform resources."
}


variable "authorized_networks" {
  description = "Authorized networks CIDRs, used in firewall rules"
  default = ""
}