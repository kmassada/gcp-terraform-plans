terraform {
  backend "gcs" {
    bucket = "terraform-for-all"
    prefix = "lab_state"
  }
}
