# Bootstrap Admin Project

module "folder" {
  source      = "../modules/folder"
  folder_name = var.folder_name
  folder_id   = var.folder_id # parent
}

module "project" {
  source              = "../modules/project"
  project_name_prefix = "TF Admin"
  project_id_prefix   = "tf-admin"
  folder_id           = module.folder.folder_name
  billing_account     = var.billing_account
  depends_on = [
    module.folder
  ]
}

module "api_services" {
  source     = "../modules/project-services"
  project_id = module.project.project_id
  api_services = [
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com"
  ]
  depends_on = [
    module.project
  ]
}
resource "local_file" "terraform_tfvars" {
  filename = "../terraform_tfvars"
  content = <<-EOT
    org_ig = ${var.org_id}
    folder_id = ${module.folder.folder_name}
    billing_account = ${var.billing_account}
    admin_project = ${var.module.project.project_id}
  EOT
}