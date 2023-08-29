data "google_container_engine_versions" "fetch_version" {
  provider       = google-beta
  project = var.project_id
  location       = var.location
  version_prefix = var.version_prefix
}

resource "google_container_cluster" "main" {
  provider           = google-beta
  name               = var.cluster_name
  initial_node_count = 1
  project            = var.project_id
  location           = var.location
  node_config {
    service_account = var.service_account_email
  }

  release_channel {
    channel = var.release_channel
  }


  min_master_version = data.google_container_engine_versions.fetch_version.release_channel_latest_version["${var.release_channel}"]

  network    = var.network_name
  subnetwork = var.create_custom_range ? var.subnet_name : ""

  ip_allocation_policy {
    cluster_secondary_range_name  = var.create_custom_range ? var.pod_range_name : ""
    services_secondary_range_name = var.create_custom_range ? var.service_range_name : ""
  }

  dynamic "master_authorized_networks_config" {
    for_each = length(var.master_authorized_networks) > 0 ? [1] : []
    content {
      cidr_blocks {
        cidr_block = var.master_authorized_networks
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = var.master_global_access_config
    }
  }

  networking_mode = var.networking_mode

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
