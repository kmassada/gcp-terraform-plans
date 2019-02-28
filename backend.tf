terraform {
 backend "gcs" {
   bucket  = "tf-terraform-admin"
   prefix  = "terraform/state"
   project = "tf-terraform-admin"
 }
}
