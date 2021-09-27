# terraform-module-example

Terraform module which creates Null resources.

<!-- BEGIN_TF_DOCS -->
## Examples

```hcl
module "example" {
  source = "git@github.com:tmknom/terraform-module-example.git?ref=tags/v0.1.0"

  name = "example"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Resource name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Resource name |
<!-- END_TF_DOCS -->
