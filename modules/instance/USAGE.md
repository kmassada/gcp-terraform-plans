

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Provide Name of Instance | `string` | `"bastion"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Terraform Generated network | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Terraform Generated Project ID | `any` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Email of Service Acccount | `any` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Terraform Generated subnet | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | n/a |
| <a name="output_instance_zone"></a> [instance\_zone](#output\_instance\_zone) | n/a |