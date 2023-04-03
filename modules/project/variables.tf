variable "org_id" {
  description = "The ID of the Google Cloud Organization."
}

variable "folder_id" {
  description = "The ID of the Google Cloud Folder."
}

variable "billing_account" {
  description = "The ID of the associated billing account (optional)."
}

variable "project_name_prefix" {
  description = "The Prefix of the Project Name."
  default     = "TF Proj"
}

variable "project_id_prefix" {
  description = "The Prefix of the Project ID."
  default     = "tf-btstrp-proj"
}