## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_services"></a> [api\_services](#module\_api\_services) | ./modules/project-services | n/a |
| <a name="module_gke_cluster"></a> [gke\_cluster](#module\_gke\_cluster) | ./modules/gke-cluster | n/a |
| <a name="module_gke_cluster_dpv2-pub-ext-endpt"></a> [gke\_cluster\_dpv2-pub-ext-endpt](#module\_gke\_cluster\_dpv2-pub-ext-endpt) | ./modules/gke-cluster | n/a |
| <a name="module_gke_cluster_dpv2-pub-int-endpt"></a> [gke\_cluster\_dpv2-pub-int-endpt](#module\_gke\_cluster\_dpv2-pub-int-endpt) | ./modules/gke-cluster | n/a |
| <a name="module_gke_cluster_dpv2-pv-endpt"></a> [gke\_cluster\_dpv2-pv-endpt](#module\_gke\_cluster\_dpv2-pv-endpt) | ./modules/gke-cluster | n/a |
| <a name="module_gke_network"></a> [gke\_network](#module\_gke\_network) | ./modules/network | n/a |
| <a name="module_gke_node_sa"></a> [gke\_node\_sa](#module\_gke\_node\_sa) | ./modules/iam-roles | n/a |
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instance | n/a |
| <a name="module_instance_sa"></a> [instance\_sa](#module\_instance\_sa) | ./modules/iam-roles | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_project"></a> [project](#module\_project) | ./modules/project | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnet | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_project"></a> [admin\_project](#input\_admin\_project) | Admin Project to manage other Terraform resources. | `any` | n/a | yes |
| <a name="input_admin_sa"></a> [admin\_sa](#input\_admin\_sa) | Admin ServiceAccount name to manage other Terraform resources. | `any` | n/a | yes |
| <a name="input_admin_sa_id"></a> [admin\_sa\_id](#input\_admin\_sa\_id) | Admin ServiceAccount ID to manage other Terraform resources. | `any` | n/a | yes |
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | Authorized networks CIDRs, used in firewall rules | `string` | `""` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The ID of the associated billing account (optional). | `any` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the Google Cloud Folder. | `any` | n/a | yes |
| <a name="input_min_master_version"></a> [min\_master\_version](#input\_min\_master\_version) | n/a | `string` | `"1.25"` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the Google Cloud Organization. | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west1"` | no |
| <a name="input_region_zone"></a> [region\_zone](#input\_region\_zone) | n/a | `string` | `"us-west1-a"` | no |