terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_id" "project_name" {
  byte_length = 8
}

resource "google_project" "tf_project" {
  name            = "TF BT ${random_id.project_name.hex}"
  project_id      = "tf-btstrp-${random_id.project_name.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

resource "google_project_service" "tf_project_compute" {
  project = google_project.tf_project.project_id
  service = "compute.googleapis.com"
  disable_dependent_services = false
  depends_on   = [
    google_project.tf_project
  ]
}

resource "google_project_service" "tf_project_container" {
  project = google_project.tf_project.project_id
  service = "container.googleapis.com"
  disable_dependent_services = false
  depends_on   = [
    google_project_service.tf_project_compute
  ]
}
