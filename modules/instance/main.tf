resource "google_compute_instance" "instance" {
  name         = "tf-${var.instance_name}"
  machine_type = "e2-micro"
  project      = var.project_id

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    access_config {
      nat_ip = ""
    }
    network = var.network_name
    subnetwork = var.subnet_name
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
