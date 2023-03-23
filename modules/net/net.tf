resource "google_compute_network" "tf_net" {
  name                    = "${var.network}"
  project                 = "${var.project_id}"
  auto_create_subnetworks = false
    provisioner "local-exec" {
    when    = "create"
    command = "sleep 10"
  }
}

resource "google_compute_subnetwork" "tf_subnet" {
  name          = "${var.subnetwork}"
  project       = "${var.project_id}"
  network       = "${google_compute_network.tf_net.name}"
  ip_cidr_range = "${var.subnetwork_ip_cidr_range}"

  secondary_ip_range {
    range_name    = "containerrange1"
    ip_cidr_range = "192.168.0.0/16"
  }

  private_ip_google_access = true

  depends_on = [
    "google_compute_subnetwork.tf_subnet"
  ]
}

resource "google_compute_firewall" "tf_net_allow_ssh" {
  name    = "tf-net-allow-ssh"
  network = "${google_compute_network.tf_net.name}"
  project = "${var.project_id}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.network_allow_ssh_source_ranges}"
}
