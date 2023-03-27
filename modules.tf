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
    module.network
  ]
}

module "instance" {
  source = "./modules/instance"
  subnet = module.network.subnet
  project_id = module.project.project_id
  service_account_email = instance_sa.service_account_email
  depends_on = [
    module.network,
    module.instance_sa
  ]
}

# module "gke_pv_cluster" {
#   source = "plan/gke-pv-cluster"
#   network                    = module.network.network
#   region                     = var.region
#   min_master_version         = var.min_master_version
#   subnet                 = module.network.subnet
#   subnet_ip_cidr_range   = module.network.subnet_ip_cidr_range
#   project_id                 = module.project.project_id
# }
