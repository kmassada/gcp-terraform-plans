

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_folder.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_org_id"></a> [enable\_org\_id](#input\_enable\_org\_id) | Decide whethere to use org ID or folder ID as the parent | `bool` | `false` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The  ID of the Google Cloud Parent Folder. | `any` | n/a | yes |
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | The  Name of the Google Cloud Folder. | `any` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the Google Cloud Organization. (optional) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_folder_name"></a> [folder\_name](#output\_folder\_name) | n/a |