output "network" {
  value = "${google_compute_network.neuron_tf.name}"
}

output "subnetwork" {
  value = "${google_compute_subnetwork.neuron_subnet_tf.name}"
}

output "subnetwork_ip_cidr_range" {
  value = "${google_compute_subnetwork.neuron_subnet_tf.ip_cidr_range}"
}
