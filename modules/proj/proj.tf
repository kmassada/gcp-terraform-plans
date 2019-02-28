provider "random" {}

resource "random_id" "project_name" {
  byte_length = 8
}

resource "google_project" "tf_project" {
  name            = "TF Bootstraped Project"
  project_id      = "tf-btstrp-${random_id.project_name.hex}"
  org_id          = "${var.org_id}"
  billing_account = "${var.billing_account}"
}

resource "google_project_services" "tf_project" {
  project = "${google_project.tf_project.project_id}"
  services = ["compute.googleapis.com", "container.googleapis.com"]
  depends_on = ["google_project.tf_project"]
}
