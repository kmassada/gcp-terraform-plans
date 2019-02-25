resource "google_compute_network" "neuron_tf" {
  name                    = "${var.network}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "neuron_subnet_tf" {
  name          = "${var.subnetwork}"
  network       = "${google_compute_network.neuron_tf.name}"
  ip_cidr_range = "${var.subnetwork_ip_cidr_range}"

  secondary_ip_range {
    range_name    = "containerrange1"
    ip_cidr_range = "192.168.0.0/16"
  }

  private_ip_google_access = true
}
