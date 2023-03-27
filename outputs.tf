# output "cluster_name" {
#   value = module.gke_pv_cluster.cluster_name
# }

# output "cluster_region" {
#   value = module.gke_pv_cluster.cluster_region
# }

output "project_id" {
  value = module.project.project_id
}

output "instance_name" {
  value = module.instance.instance_name
}

output "instance_zone" {
  value = module.instance.instance_zone
}