output "network" {
  value = google_compute_network.net_tf.name
}

output "subnet" {
  value = google_compute_subnetwork.subnet_tf.name
}

output "subnet_ip_cidr_range" {
  value = google_compute_subnetwork.subnet_tf.ip_cidr_range
}
