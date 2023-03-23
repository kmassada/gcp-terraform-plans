# output "cluster_name" {
#   value = "${module.gke_pv_cluster.cluster_name}"
# }

# output "cluster_region" {
#   value = "${module.gke_pv_cluster.cluster_region}"
# }

output "project_id" {
  value = "${module.proj.project_id}"
}

output "jumper_name" {
  value = "${module.jumper.jumper_name}"
}

output "jumper_zone" {
  value = "${module.jumper.jumper_zone}"
}