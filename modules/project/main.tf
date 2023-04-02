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
  name            = "TF Proj ${random_id.project_name.hex}"
  project_id      = "tf-btstrp-proj-${random_id.project_name.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}
