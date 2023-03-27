module "project" {
  source = "./modules/project"
  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

module "network" {
  source = "./modules/network"
  project_id = module.project.project_id
  depends_on = [
    module.project
  ]
}

module "instance" {
  source = "./modules/instance"
  subnet = module.network.subnet
  project_id = module.project.project_id
  depends_on = [
    module.project
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
