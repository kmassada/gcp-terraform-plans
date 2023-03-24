resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa-tf"
  display_name = "GKE Node Service Account"
  project      = var.project_id

}

resource "google_project_iam_binding" "node_nodeServiceAccount" {
  role               = "roles/roles/container.nodeServiceAccount"
  project            = var.project_id
  members = ["serviceAccount:${google_service_account.gke_node_sa.email}"]
}