
variable "region" {
  default = "us-west1"
}

variable "region_zone" {
  default = "us-west1-a"
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
