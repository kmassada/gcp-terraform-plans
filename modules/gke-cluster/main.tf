data "google_container_engine_versions" "fetch_version" {
  provider       = google-beta
  location       = var.region
  version_prefix = var.version_prefix
}

resource "google_container_cluster" "primary" {
  provider           = google-beta
  name               = var.cluster_name
  initial_node_count = 1
  project            = var.project_id
  location           = var.region
  node_config {
    service_account = var.service_account_email
  }

  release_channel {
    channel = var.release_channel
  }

# TODO: will only work for RAPID/REGULAR
#
# "release_channel_latest_version": {
#   "RAPID": "1.25.7-gke.1000",
#   "REGULAR": "1.25.6-gke.1000"
# },

min_master_version = data.google_container_engine_versions.fetch_version.release_channel_latest_version["${var.release_channel}"]

  network = var.network
  subnetwork = var.subnet

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled =var.master_global_access_config
    }
  }

  datapath_provider = var.dataplane_v2

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  logging_config {
    enable_components = [
        "SYSTEM_COMPONENTS", 
        "WORKLOADS", 
        "APISERVER", 
        "CONTROLLER_MANAGER", 
        "SCHEDULER"
      ]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
