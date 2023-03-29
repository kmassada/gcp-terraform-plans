variable "project_id" {
  description =  "Terraform Generated Project ID"
  type = string
}

variable "network_name" {
  default = "tf-net"
  type = string
}

variable "subnet_name" {
  default = "tf-subnet"
  type = string
}

variable "subnet_ip_cidr_range" {
  description = "CIDR range used for subnet"
  default = "10.128.0.0/20"
  type = string
}

variable "pod_range" {
  type = object({
    name = string
    cidr = string
  })
  default = {
    cidr = "10.8.0.0/14"
    name = "podrange1"
  }
}
variable "service_range" {
  type = object({
    name = string
    cidr = string
  })
  default = {
    cidr = "10.12.0.0/20"
    name = "servicerange1"
  }
}