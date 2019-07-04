output "jumper_name" {
  value = "${google_compute_instance.jumper_tf.name}"
}

output "jumper_zone" {
  value = "${google_compute_instance.jumper_tf.zone}"
}