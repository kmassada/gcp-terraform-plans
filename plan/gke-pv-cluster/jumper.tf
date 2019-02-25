resource "google_compute_instance" "jumper_tf" {
  name         = "jumper-tf"
  machine_type = "f1-micro"

  service_account = {
    email  = "${google_service_account.jumper_sa.email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    subnetwork = "${module.net.subnet_name}"
  }

  boot_disk {
    initialize_params {
      size  = 10
      type  = "pd-standard"
      image = "debian-9-stretch-v20190213"
    }
  }
}
