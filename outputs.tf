# output "cluster_name" {
#   value = module.gke_pv_cluster.cluster_name
# }

# output "cluster_region" {
#   value = module.gke_pv_cluster.cluster_region
# }

output "project_id" {
  value = module.project.project_id
}

output "tf_instance_name" {
  value = module.instance.tf_instance_name
}

output "tf_instance_zone" {
  value = module.instance.tf_instance_zone
}