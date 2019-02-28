provider "google" {
  credentials = "${var.creds}"
  region  = "${var.region}"
  zone    = "${var.region_zone}"
}