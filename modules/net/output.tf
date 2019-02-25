output "network_name" {
  value = "${google_compute_network.neuron_tf.name}"
}

output "subnet_name" {
  value = "${google_compute_subnetwork.neuron_subnet_tf.name}"
}

output "subnet_ip_cidr_range" {
  value = "${google_compute_subnetwork.neuron_subnet_tf.ip_cidr_range}"
}
