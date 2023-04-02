variable "network_name" {
  default = "tf-net"
  type    = string
}

variable "auto_create_subnetworks" {
  default     = false
  description = "Automatically create subnets or not"
}

variable "project_id" {
  description = "Terraform Generated Project ID"
  type        = string
}

variable "network_allow_ssh_source_ranges" {
  default = ["0.0.0.0/0"]
}
