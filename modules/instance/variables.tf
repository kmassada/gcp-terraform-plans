variable "project_id" {
    description =  "Terraform Generated Project ID"    
}

variable "subnet_name" {
    description =  "Terraform Generated subnet"
}

variable "network_name" {
    description =  "Terraform Generated network"
}

variable "instance_name" {
    description = "Provide Name of Instance"
    default     = "bastion"
}

variable "service_account_email" {
    description = "Email of Service Acccount"
}