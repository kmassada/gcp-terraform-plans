# Bootstrap Project and Bastion

module "project" {
  source = "./modules/project"
  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

module "enable_api_services" {
  source = "./modules/project-services"
  project_id = module.project.project_id
  api_services = [
    "compute.googleapis.com",
    "container.googleapis.com"
  ]
  depends_on = [
    module.project
  ]
}

module "network" {
  source = "./modules/network"
  project_id = module.project.project_id
  depends_on = [
    module.enable_api_services
  ]
}

module "subnet" {
  source = "./modules/subnet"
  project_id = module.project.project_id
  depends_on = [
    module.network
  ]
}

module "instance_sa" {
  source = "./modules/iam-roles"
  project_id = module.project.project_id
  service_account_name = "bastion-node"
  service_account_roles = [
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/logging.logWriter",
    "roles/container.developer"
  ]
  depends_on = [
    module.network,
    module.subnet
  ]
}

module "instance" {
  source = "./modules/instance"
  network = module.network.network_name_name
  subnet = module.subnet.subnet_name
  project_id = module.project.project_id
  service_account_email = module.instance_sa.service_account_email
  depends_on = [
    module.network,
    module.subnet,
    module.instance_sa
  ]
}

# Create GKE cluster

module "gke_node_sa" {
  source = "./modules/iam-roles"
  project_id = module.project.project_id
  service_account_name = "gke-node"
  service_account_roles = [
    "roles/container.nodeServiceAccount"
  ]
  depends_on = [
    module.enable_api_services
  ]
}

module "gke_cluster" {
  source                       = "./modules/gke-cluster"
  cluster_name                 = "gke-cluster"
  network_name                 = module.network.network_name
  location                     = var.region
  subnet_name                  = module.subnet.subnet_name
  project_id                   = module.project.project_id
  service_account_email        = module.gke_node_sa.service_account_email
  pod_range_name               = module.subnet.pod_range_name
  service_range_name           = module.subnet.service_range_name
  dataplane_v2                 = "ADVANCED_DATAPATH"
  master_ipv4_cidr_block       = "172.16.0.0/28"
  enable_private_endpoint      = false
  enable_private_nodes         = true
  master_global_access_config  = true
  create_custom_range          = true

  depends_on = [
    module.gke_node_sa,
    module.network,
    module.subnet
  ]
}

# Create many GKE Clusters

module "gke_network" {
  source = "./modules/network"
  network_name = "tf-gke-net"
  auto_create_subnetworks = true
  project_id = module.project.project_id
  depends_on = [
    module.enable_api_services
  ]
}

module "gke_cluster_dpv2-pv-endpt" {
  source                       = "./modules/gke-cluster"
  cluster_name                 = "gke-cluster-dpv2-pv-endpt"
  network_name                 = module.gke_network.network_name
  location                     = "us-west3-a"
  project_id                   = module.project.project_id
  service_account_email        = module.gke_node_sa.service_account_email
  dataplane_v2                 = "ADVANCED_DATAPATH"
  master_ipv4_cidr_block       = "172.16.0.16/28"
  enable_private_endpoint      = true
  enable_private_nodes         = true
  master_global_access_config  = true
  create_custom_range          = false

  depends_on = [
    module.gke_node_sa,
    module.gke_network
  ]
}