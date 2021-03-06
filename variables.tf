
variable "region" {
  default = "asia-east1"
}

variable "region_zone" {
  default = "asia-east1-a"
}

variable "min_master_version" {
  default = "1.13"
}

variable "org_id" {
  description = "The ID of the Google Cloud Organization."
}

variable "billing_account" {
  description = "The ID of the associated billing account (optional)."
}

variable "creds" {
  description = "The Full path to the creds of the serviceaccount."
}
