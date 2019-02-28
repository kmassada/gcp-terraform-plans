resource "google_service_account" "jumper_sa" {
  account_id   = "jumper-node-sa-tf"
  display_name = "Jumper Node Service Account"
  project      = "${var.project_id}"
}

resource "google_project_iam_binding" "jumper_metricWriter" {
  role = "roles/monitoring.metricWriter"
  project = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}

resource "google_project_iam_binding" "jumper_monitoring_viewer" {
  role = "roles/monitoring.viewer"
  project = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}

resource "google_project_iam_binding" "jumper_logWriter" {
  role = "roles/logging.logWriter"
  project = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}

resource "google_project_iam_binding" "jumper_container_developer" {
  role = "roles/container.developer"
  project = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}