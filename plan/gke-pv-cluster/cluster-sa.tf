resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa-tf"
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_binding" "node_metricWriter" {
  role               = "roles/monitoring.metricWriter"

  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}

resource "google_project_iam_binding" "node_monitoring_viewer" {
  role               = "roles/monitoring.viewer"

  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}

resource "google_project_iam_binding" "node_logWriter" {
  role               = "roles/logging.logWriter"

  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}