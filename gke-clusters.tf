locals {
  gke_cluster_config = {
    gke-cluster-1 = {
      "podrange"                = "10.8.0.0/14"
      "servicerange"            = "10.12.0.0/20"
      "enable_private_endpoint" = false
      "create_custom_range"     = true
      "network_name"            = module.network["tf-net"].network_name
      "subnet_name"             = module.network["tf-net"].subnet_name["tf-subnet"]
      "pod_range_name"          = var.tf_subnet_config.tf-subnet.podrange
      "service_range_name"      = var.tf_subnet_config.tf-subnet.servicerange

    }
    gke-cluster-dpv2-pv-endpt = {
      "location"                   = "us-west3-a"
      "master_authorized_networks" = "10.0.0.0/8"

    }
    gke-cluster-dpv2-pub-int-endpt = {
      "location"                = "us-west3-b"
      "master_ipv4_cidr_block"  = "172.16.0.32/28"
      "enable_private_endpoint" = false

    }
    gke-cluster-dpv2-pub-ext-endpt = {
      "location"                = "us-west3-c"
      "master_ipv4_cidr_block"  = ""
      "enable_private_endpoint" = false

    }
  }


}



module "gke_cluster" {
  for_each                    = local.gke_cluster_config
  source                      = "./modules/gke-cluster"
  cluster_name                = each.key
  network_name                = try(each.value.network_name, module.network["tf-gke-net"].network_name)
  location                    = try(each.value.location, var.region)
  subnet_name                 = try(each.value.subnet_name, "")
  project_id                  = try(each.value.project_id, google_project.lab_project.id)
  service_account_email       = try(each.value.service_account_email, module.service-accounts["gke-node-sa"].service_account_email)
  pod_range_name              = try(each.value.pod_range_name, "")
  service_range_name          = try(each.value.service_range_name, "")
  dataplane_v2                = try(each.value.dataplane_v2, "ADVANCED_DATAPATH")
  master_ipv4_cidr_block      = try(each.value.master_ipv4_cidr_block, "172.16.0.0/28")
  enable_private_endpoint     = try(each.value.enable_private_endpoint, true)
  enable_private_nodes        = try(each.value.enable_private_nodes, true)
  master_global_access_config = try(each.value.master_global_access_config, true)
  create_custom_range         = try(each.value.create_custom_range, false)
  master_authorized_networks  = try(each.value.master_authorized_networks, "")


}


