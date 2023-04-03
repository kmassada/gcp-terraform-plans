resource "google_folder" "main" {
  display_name = var.folder_name
  parent       = var.enable_org_id ? "organizations/${var.org_id}" : "folders/${var.folder_id}"
}
