variable "api_services" {
  description = "Service APIs to enable."
  type        = list(string)
  default     = []
}

variable "api_service_config" {
  description = "Configure service API activation."
  type = object({
    disable_on_destroy         = bool
    disable_dependent_services = bool
  })
  default = {
    disable_on_destroy         = false
    disable_dependent_services = false
  }
}

variable "project_id" {
  description = "Terraform Generated Project ID"
}