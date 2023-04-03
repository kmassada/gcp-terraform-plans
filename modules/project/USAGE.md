

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [random_id.project_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The ID of the associated billing account (optional). | `any` | n/a | yes |
| <a name="input_enable_org_id"></a> [enable\_org\_id](#input\_enable\_org\_id) | Decide whethere to use org ID or folder ID as the parent | `bool` | `false` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the Google Cloud Folder. | `any` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the Google Cloud Organization. (optional) | `string` | `""` | no |
| <a name="input_project_id_prefix"></a> [project\_id\_prefix](#input\_project\_id\_prefix) | The Prefix of the Project ID. | `string` | `"tf-btstrp-proj"` | no |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | The Prefix of the Project Name. | `string` | `"TF Proj"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |