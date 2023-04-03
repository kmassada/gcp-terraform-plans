variable "org_id" {
  description = "The ID of the Google Cloud Organization."
}

variable "folder_id" {
  description = "The ID of the Google Cloud Folder."
}

variable "billing_account" {
  description = "The ID of the associated billing account (optional)."
}

variable "folder_name" {
  description = "The  Name of the Google Cloud Folder."
  default     = "tf-folder"
}