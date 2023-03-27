variable "project_id" {
    description =  "Terraform Generated Project ID"    
}

variable "subnet" {
    description =  "Terraform Generated subnet"
}

variable "instance_name" {
    description = "Provide Name of Instance"
    default     = "bastion"
}

variable "service_account_email" {
    description = "Email of Service Acccount"
}