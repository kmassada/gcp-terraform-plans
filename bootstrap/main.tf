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

module "admin_tf_backend" {
  source         = "../modules/tf-backend"
  bucket_name    = module.project.project_id
  bucket_project = module.project.project_id
}

resource "terraform_data" "outputs" {
  provisioner "local-exec" {
    command = "mkdir -p ./output/"
  }
}

resource "local_file" "terraform_tfvars" {
  filename = "./output/terraform_tfvars"
  content  = <<-EOT
    org_ig = ${var.org_id}
    folder_id = ${module.folder.folder_name}
    billing_account = ${var.billing_account}
    admin_project = ${module.project.project_id}
  EOT
  depends_on = [
    module.admin_tf_backend,
    terraform_data.outputs
  ]
}