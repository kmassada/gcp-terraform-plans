resource "google_compute_instance" "tf_instance" {
  name         = "tf-${var.instance_name}"
  machine_type = "e2-micro"
  project      = var.project_id

  service_account {
    email  = google_service_account.tf_instance_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    access_config {
      nat_ip = ""
    }
    subnetwork = var.subnet
    subnetwork_project = var.project_id
  }

  boot_disk {
    initialize_params {
      size  = 64
      type  = "pd-ssd"
      image = "debian-cloud/debian-11"
    }
  }

  tags = ["allow-ssh"]
}
