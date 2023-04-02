resource "google_compute_network" "main" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks
  description             = "Network created by Terraform"
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
