variable "network" {
  default = "neuron-tf"
}

variable "subnetwork" {
  default = "neuron-subnet-tf"
}

variable "subnetwork_ip_cidr_range" {
  default = "10.128.0.0/16"
}

variable "project_id" {
    description =  "Terraform Generated Project ID"    
}

variable "network_allow_ssh_source_ranges" {
  default = ["0.0.0.0/0"]
}