resource "google_compute_network" "net" {
  name                    = var.network
  project                 = var.project_id
  auto_create_subnetworks = false
  description 		        = "Network created by Terraform"
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet
  project       = var.project_id
  network       = google_compute_network.net.name
  ip_cidr_range = var.subnet_ip_cidr_range
  description 	= "Subnet created by Terraform"
  secondary_ip_range =[
    {
      range_name    = var.pod_range.name
      ip_cidr_range = var.pod_range.cidr
    },
    {
      range_name    = var.service_range.name
      ip_cidr_range = var.service_range.cidr
    }
  ]
  private_ip_google_access = true

  depends_on = [
    google_compute_subnetwork.subnet
  ]
}

resource "google_compute_firewall" "net_allow_ssh" {
  name    = "tf-net-allow-ssh"
  network = google_compute_network.net.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["allow-ssh"]

  source_ranges = var.network_allow_ssh_source_ranges
}
