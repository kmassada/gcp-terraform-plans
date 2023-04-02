resource "google_project_service" "api_services" {
  for_each                   = toset(var.api_services)
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.api_service_config.disable_on_destroy
  disable_dependent_services = var.api_service_config.disable_dependent_services
}