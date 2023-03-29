

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"tf-net"` | no |
| <a name="input_pod_range"></a> [pod\_range](#input\_pod\_range) | n/a | <pre>object({<br>    name = string<br>    cidr = string<br>  })</pre> | <pre>{<br>  "cidr": "10.8.0.0/14",<br>  "name": "podrange1"<br>}</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Terraform Generated Project ID | `string` | n/a | yes |
| <a name="input_service_range"></a> [service\_range](#input\_service\_range) | n/a | <pre>object({<br>    name = string<br>    cidr = string<br>  })</pre> | <pre>{<br>  "cidr": "10.12.0.0/20",<br>  "name": "servicerange1"<br>}</pre> | no |
| <a name="input_subnet_ip_cidr_range"></a> [subnet\_ip\_cidr\_range](#input\_subnet\_ip\_cidr\_range) | CIDR range used for subnet | `string` | `"10.128.0.0/20"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `string` | `"tf-subnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pod_range_name"></a> [pod\_range\_name](#output\_pod\_range\_name) | n/a |
| <a name="output_service_range_name"></a> [service\_range\_name](#output\_service\_range\_name) | n/a |
| <a name="output_subnet_ip_cidr_range"></a> [subnet\_ip\_cidr\_range](#output\_subnet\_ip\_cidr\_range) | n/a |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | n/a |