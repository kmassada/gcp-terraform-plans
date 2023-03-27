output "network" {
  value = google_compute_network.net.name
}

output "subnet" {
  value = google_compute_subnetwork.subnet.name
}

output "subnet_ip_cidr_range" {
  value = google_compute_subnetwork.subnet.ip_cidr_range
}
