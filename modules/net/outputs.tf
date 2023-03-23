output "network" {
  value = "${google_compute_network.tf_net.name}"
}

output "subnet" {
  value = "${google_compute_subnet.tf_subnet.name}"
}

output "subnet_ip_cidr_range" {
  value = "${google_compute_subnet.tf_subnet.ip_cidr_range}"
}
