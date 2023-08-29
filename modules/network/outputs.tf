output "network_name" {
  value = google_compute_network.main.name
}

output "subnet_name" {
  value = {
    for k, subnet in google_compute_subnetwork.main: k=> subnet.name
  }
}