resource "google_service_account" "main" {
  account_id   = "tf-${var.service_account_name}-sa"
  display_name = "${var.service_account_name} Service Account"
  project      = var.project_id
}

resource "google_project_iam_binding" "service_account_roles" {
  for_each  = toset(var.service_account_roles)
  project   = var.project_id
  role      = each.value
  members   = ["serviceAccount:${google_service_account.main.email}"]  
  lifecycle {
    ignore_changes =[members]
  }
  depends_on   = [
    google_service_account.main
  ]
}