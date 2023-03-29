

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google-beta_google_container_engine_versions.fetch_version](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_container_engine_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the GKE Cluster | `string` | `"gke-cluster"` | no |
| <a name="input_create_custom_range"></a> [create\_custom\_range](#input\_create\_custom\_range) | Wether to provide own pod/service range | `bool` | `true` | no |
| <a name="input_dataplane_v2"></a> [dataplane\_v2](#input\_dataplane\_v2) | Dataplane v2 enabled? | `string` | `"ADVANCED_DATAPATH"` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Private endpoint to Kubernetes API Server | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | Private nodes to Kubernetes API Server | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Terraform Set Region/Zone | `any` | n/a | yes |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | Master Authorized Networks | `string` | `""` | no |
| <a name="input_master_global_access_config"></a> [master\_global\_access\_config](#input\_master\_global\_access\_config) | Controls cluster master global access settings | `bool` | `true` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | Private IPv4 CIDR range of control plane | `string` | `"172.16.0.0/28"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Terraform Generated network | `any` | n/a | yes |
| <a name="input_networking_mode"></a> [networking\_mode](#input\_networking\_mode) | Mode of Networking: Options are VPC\_NATIVE or ROUTES | `string` | `"VPC_NATIVE"` | no |
| <a name="input_pod_range_name"></a> [pod\_range\_name](#input\_pod\_range\_name) | Name of IPv4 CIDR range of pod IPs | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Terraform Generated Project ID | `any` | n/a | yes |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Set the release channel of the cluster | `string` | `"RAPID"` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Email of the GKE Node Service Account | `any` | n/a | yes |
| <a name="input_service_range_name"></a> [service\_range\_name](#input\_service\_range\_name) | Name of IPv4 CIDR range of services IPs | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Terraform Generated subnet | `string` | `""` | no |
| <a name="input_version_prefix"></a> [version\_prefix](#input\_version\_prefix) | Prefix of the GKE Cluster version | `string` | `"1.25"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_location"></a> [cluster\_location](#output\_cluster\_location) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |