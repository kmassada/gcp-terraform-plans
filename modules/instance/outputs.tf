output "tf_instance_name" {
  value = google_compute_instance.tf_instance.name
}

output "tf_instance_zone" {
  value = google_compute_instance.tf_instance.zone
}