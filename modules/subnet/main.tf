resource "google_compute_subnetwork" "main" {
  name          = var.subnet_name
  project       = var.project_id
  network       = var.network_name
  ip_cidr_range = var.subnet_ip_cidr_range
  description   = "Subnet created by Terraform"
  secondary_ip_range = [
    {
      range_name    = var.pod_range.name
      ip_cidr_range = var.pod_range.cidr
    },
    {
      range_name    = var.service_range.name
      ip_cidr_range = var.service_range.cidr
    }
  ]
  private_ip_google_access = true
}