module "proj" {
  source = "./modules/proj"
  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

module "net" {
  source = "./modules/net"
  project_id = module.proj.project_id
}

module "jumper" {
  source = "./modules/jumper"
  subnet = module.net.subnet
  project_id = module.proj.project_id
}

# module "gke_pv_cluster" {
#   source = "plan/gke-pv-cluster"
#   network                    = module.net.network
#   region                     = var.region
#   min_master_version         = var.min_master_version
#   subnet                 = module.net.subnet
#   subnet_ip_cidr_range   = module.net.subnet_ip_cidr_range
#   project_id                 = module.proj.project_id
# }
