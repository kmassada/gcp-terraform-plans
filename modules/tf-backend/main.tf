resource "google_storage_bucket" "admin" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true
  project       = var.bucket_project
}
resource "terraform_data" "outputs" {
  provisioner "local-exec" {
    command = "mkdir -p ./output/"
  }
}

resource "local_file" "backend_tf" {
  filename = "./output/backend_tf"
  content  = <<-EOT
    terraform {
        backend "gcs" {
            bucket  = "${var.bucket_name}"
            prefix  = "terraform/state"
        }
    }
  EOT
  depends_on = [
    terraform_data.outputs
  ]
}