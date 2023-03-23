
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

variable "creds" {
  description = "The Full path to the creds of the serviceaccount."
}
