

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.net_allow_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | Automatically create subnets or not | `bool` | `false` | no |
| <a name="input_network_allow_ssh_source_ranges"></a> [network\_allow\_ssh\_source\_ranges](#input\_network\_allow\_ssh\_source\_ranges) | n/a | `list` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"tf-net"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Terraform Generated Project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | n/a |