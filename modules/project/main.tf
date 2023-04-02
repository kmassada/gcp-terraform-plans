terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_id" "project_name" {
  byte_length = 4
}

resource "google_project" "main" {
  name            = "${var.project_name_prefix} ${random_id.project_name.hex}"
  project_id      = "${var.project_id_prefix}-${random_id.project_name.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}
