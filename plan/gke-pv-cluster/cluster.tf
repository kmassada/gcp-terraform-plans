resource "google_container_cluster" "primary" {
  name               = "pv-cluster-tf"
  initial_node_count = 3
  project            = "${var.project_id}"
  region             = "${var.region}"
  node_config {
    service_account = "${google_service_account.gke_node_sa.email}"
    metadata {
      disable-legacy-endpoints = true
  }
  }

  min_master_version = "${var.min_master_version}"

  network = "${var.network}"

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    create_subnetwork = true
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.subnetwork_ip_cidr_range}"
      display_name = "${var.subnetwork}"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

		kubernetes_dashboard {
      disabled = false
    }
  }

	logging_service = "logging.googleapis.com/kubernetes"
	monitoring_service = "monitoring.googleapis.com/kubernetes"

  timeouts {
    create = "30m"
    update = "40m"
  }
}
