resource "google_container_cluster" "primary" {
  name               = "gke-pv-cluster-tf"
  initial_node_count = 3

  node_config {
    service_account = "${google_service_account.gke_node_sa.email}"
  }

  network = "${module.net.network_name}"

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
      cidr_block   = "${module.net.subnet_ip_cidr_range}"
      display_name = "${module.net.subnet_name}"
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