variable "network" {
    description =  "Terraform Generated network"
}

variable "subnet" {
    description =  "Terraform Generated subnet"
}

variable "project_id" {
    description =  "Terraform Generated Project ID"    
}

variable "region" {
    description =  "Terraform Set Region/Zone"    
}

variable "min_master_version" {
    description =  "Terraform Set Min Master Version"    
}

variable "service_account_email" {
    description =  "Email of the GKE Node Service Account"
}

variable "cluster_name" {
    description =  "Name of the GKE Cluster"
    default = "gke-cluster"
}

variable "version_prefix" {
    description =  "Prefix of the GKE Cluster version"
    default = "1.25"
}

variable "dataplane_v2" {
    description =  "Dataplane v2 enabled?"
    default = "ADVANCED_DATAPATH"
}

variable "enable_private_endpoint" {
    description = "Private endpoint to Kubernetes API Server"
    default = false
}

variable "enable_private_nodes" {
    description = "Private nodes to Kubernetes API Server"
    default = true
}

variable "master_ipv4_cidr_block" {
    description = "Private IPv4 CIDR range of control plane"
    default = "172.16.0.0/28"
}

variable "master_global_access_config" {
    description = "Controls cluster master global access settings"
    default = true
}

variable "release_channel" {
    description = "Set the release channel of the cluster"
    default = "RAPID"
}

variable "create_custom_range" {
    description = "Wether to provide own pod/service range"
    default = true
}

variable "pod_range_name" {
    description = "Name of IPv4 CIDR range of pod IPs"
}

variable "service_range_name" {
    description = "Name of IPv4 CIDR range of services IPs"
}

variable "networking_mode" {
    description = "Mode of Networking: Options are VPC_NATIVE or ROUTES"
    default = "VPC_NATIVE"
}
