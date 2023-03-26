resource "google_service_account" "tf_instance_sa" {
  account_id   = "tf-${var.instance_name}-sa"
  display_name = "${var.instance_name} Node Service Account"
  project      = var.project_id
}

resource "google_project_iam_binding" "tf_instance_metricWriter" {
  role = "roles/monitoring.metricWriter"
  project = var.project_id
  members = ["serviceAccount:${google_service_account.tf_instance_sa.email}"]  
  lifecycle {
    ignore_changes =[members]
  }
  depends_on   = [
    google_service_account.tf_instance_sa
  ]
}

resource "google_project_iam_binding" "tf_instance_monitoring_viewer" {
  role = "roles/monitoring.viewer"
  project = var.project_id
  members = ["serviceAccount:${google_service_account.tf_instance_sa.email}"]
  lifecycle {
    ignore_changes =[members]
  }
  depends_on   = [
    google_service_account.tf_instance_sa
  ]
}

resource "google_project_iam_binding" "tf_instance_logWriter" {
  role = "roles/logging.logWriter"
  project = var.project_id
  members = ["serviceAccount:${google_service_account.tf_instance_sa.email}"]
  lifecycle {
    ignore_changes =[members]
  }
  depends_on   = [
    google_service_account.tf_instance_sa
  ]
}

resource "google_project_iam_binding" "tf_instance_container_developer" {
  role = "roles/container.developer"
  project = var.project_id
  members = ["serviceAccount:${google_service_account.tf_instance_sa.email}"]
  lifecycle {
    ignore_changes =[members]
  }
  depends_on   = [
    google_service_account.tf_instance_sa
  ]
}