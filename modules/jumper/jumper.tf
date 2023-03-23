resource "google_compute_instance" "jumper_tf" {
  name         = "jumper-tf"
  machine_type = "f1-micro"
  project      = var.project_id

  service_account = {
    email  = google_service_account.jumper_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    access_config {
      nat_ip = ""
    }
    subnet = var.subnet
    subnet_project = var.project_id
  }

  boot_disk {
    initialize_params {
      size  = 10
      type  = "pd-standard"
      image = "debian-9-stretch-v20190213"
    }
  }
}
