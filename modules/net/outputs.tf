output "network" {
  value = "${google_compute_network.tf_net.name}"
}

output "subnetwork" {
  value = "${google_compute_subnetwork.tf_subnet.name}"
}

output "subnetwork_ip_cidr_range" {
  value = "${google_compute_subnetwork.tf_subnet.ip_cidr_range}"
}
