terraform {
  backend "gcs" {
    bucket = "terraform-for-all"
    prefix = "for_labs"
  }
}
