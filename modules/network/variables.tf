variable "network_name" {
  type    = string
}

variable "auto_create_subnetworks" {
  default     = true
  description = "Automatically create subnets or not"
}

variable "project_id" {
  description = "Terraform Generated Project ID"
  type        = string
}

variable "network_allow_ssh_source_ranges" {
  default = ["0.0.0.0/0"]
}

variable "tf_subnet_config" {
  type = map(object({
        name = string
        primary_range = string
        podrange = string
        servicerange = string
  }))
  default = null
}


