resource "google_compute_network" "main" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks
  description             = "Network created by Terraform ${terraform.workspace}"
}

resource "google_compute_firewall" "net_allow_ssh" {
  name    = "${var.network_name}-allow-ssh"
  network = google_compute_network.main.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["allow-ssh"]

  source_ranges = var.network_allow_ssh_source_ranges

  depends_on = [
    google_compute_network.main
  ]
}

resource "google_compute_subnetwork" "main" {
  for_each = var.tf_subnet_config
  name          = each.key
  project       = var.project_id
  network       = var.network_name
  ip_cidr_range = each.value.primary_range
  description   = "Network created by Terraform ${terraform.workspace}"
  secondary_ip_range = [
    {
      range_name    = "podrange"
      ip_cidr_range = each.value.podrange
    },
    {
      range_name    = "servicerange"
      ip_cidr_range = each.value.servicerange
    }
  ]
  private_ip_google_access = true
}



