resource "google_folder" "main" {
  display_name = var.folder_name
  parent       = var.enable_org_id ? var.org_id : var.folder_id
}
