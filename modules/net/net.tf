resource "google_compute_network" "neuron_tf" {
  name                    = "neuron-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "neuron_subnet_tf" {
  name          = "neuron-subnet-tf"
  network       = "${google_compute_network.neuron_tf.name}"
  ip_cidr_range = "10.128.0.0/16"

  secondary_ip_range {
    range_name    = "containerrange1"
    ip_cidr_range = "192.168.0.0/16"
  }

  private_ip_google_access = true
}
