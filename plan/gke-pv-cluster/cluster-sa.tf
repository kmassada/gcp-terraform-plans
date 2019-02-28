resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa-tf"
  display_name = "GKE Node Service Account"
  project      = "${var.project_id}"

}

resource "google_project_iam_binding" "node_metricWriter" {
  role               = "roles/monitoring.metricWriter"
  project            = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}

resource "google_project_iam_binding" "node_monitoring_viewer" {
  role               = "roles/monitoring.viewer"
  project            = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}

resource "google_project_iam_binding" "node_logWriter" {
  role               = "roles/logging.logWriter"
  project            = "${var.project_id}"
  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}