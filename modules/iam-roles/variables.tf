variable "service_account_name" {
  description = "Name of the service account being created"
}

variable "service_account_roles" {
  description = "Service account roles to bind."
  type        = list(string)
  default     = []
}

variable "project_id" {
  description = "Terraform Generated Project ID"
}