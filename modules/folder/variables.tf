variable "org_id" {
  description = "The ID of the Google Cloud Organization. (optional)"
  default     = ""
}

variable "folder_id" {
  description = "The  ID of the Google Cloud Parent Folder."
}

variable "enable_org_id" {
  description = "Decide whethere to use org ID or folder ID as the parent"
  default     = false
}

variable "folder_name" {
  description = "The  Name of the Google Cloud Folder."
}