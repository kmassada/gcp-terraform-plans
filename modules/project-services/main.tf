resource "google_project_service" "project_services" {
  for_each                   = toset(var.project_services)
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.project_service_config.disable_on_destroy
  disable_dependent_services = var.project_service_config.disable_dependent_services
}