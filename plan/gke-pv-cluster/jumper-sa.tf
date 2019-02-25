resource "google_service_account" "jumper_sa" {
  account_id   = "jumper-node-sa-tf"
  display_name = "Jumper Node Service Account"
}

resource "google_project_iam_binding" "jumper_metricWriter" {
  role = "roles/monitoring.metricWriter"

  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}

resource "google_project_iam_binding" "jumper_monitoring_viewer" {
  role = "roles/monitoring.viewer"

  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}

resource "google_project_iam_binding" "jumper_logWriter" {
  role = "roles/logging.logWriter"

  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}

resource "google_project_iam_binding" "jumper_container_developer" {
  role = "roles/container.developer"

  members = ["serviceAccount:${google_service_account.jumper_sa.email}"]
}