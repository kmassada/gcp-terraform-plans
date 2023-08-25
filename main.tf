resource "google_project" "lab_project" {
  name       = terraform.workspace
  project_id = terraform.workspace
  folder_id  = var.folder_id
}

resource "google_project_service" "api_services" {
  for_each                   = toset(var.api_services)
  project                    = google_project.lab_project.id
  service                    = each.value
  disable_on_destroy         = false
  disable_dependent_services = false
}

module "network" {
  for_each                        = var.networks_config
  network_name                    = each.key
  source                          = "./modules/network"
  depends_on                      = [google_project_service.api_services]
  project_id                      = google_project.lab_project.id
  auto_create_subnetworks         = each.value.auto_create_subnetworks
  network_allow_ssh_source_ranges = ["0.0.0.0/0"]
  tf_subnet_config                = each.value.auto_create_subnetworks ? {} : var.tf_subnet_config
}

module "service-accounts" {
  for_each              = var.service_accounts
  source                = "./modules/iam-roles"
  project_id            = google_project.lab_project.id
  service_account_name  = each.key
  service_account_roles = each.value
  depends_on = [
    google_project_service.api_services
  ]
}


resource "google_compute_instance" "bastion" {
  name         = "bastion-${terraform.workspace}"
  machine_type = "e2-micro"
  project      = google_project.lab_project.id

  service_account {
    email  = module.service-accounts["bastion"].service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    access_config {
      nat_ip = ""
    }
    network            = module.network["tf-net"].network_name
    subnetwork         = module.network["tf-net"].subnet_name["tf-subnet"]
    subnetwork_project = google_project.lab_project.id
  }

  boot_disk {
    initialize_params {
      size  = 64
      type  = "pd-ssd"
      image = "debian-cloud/debian-11"
    }
  }

  tags = ["allow-ssh"]
}










