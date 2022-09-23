# Azure Tenant Management Terraform Module

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

<!--- Replace repository name -->
![License](https://badgen.net/github/license/getindata/terraform-azurerm-tenant-management/)
![Release](https://badgen.net/github/release/getindata/terraform-azurerm-tenant-management/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

This module will help you set up a governance for your Azure platform. 
It will attempt to create a tree of management Groups and will associate already defined or new subscriptions with them.
On top of that the module allows you to attach built-in policies either to management groups or subscriptions.
The module also supports RBAC with Azure AD - it allows you to create Azure AD groups with role assignments of your choice
to specific scope e.g. subscription or management groups.

## USAGE
```terraform
module "platform_management" {
  source = "github.com/getindata/terraform-azurerm-tenant-management"

  management_groups = {
    level_1_mgmt_group = {
      policies = {
        allowed_locations = {
          display_name = "Allowed locations" #Built-in policy
          parameters = {
            listOfAllowedLocations = [
              "West Europe"
            ]  
          }
        }  
      }
      management_groups = {
        level_2_mgmt_group = {
          subscriptions = {
            pay-as-you-go-main = {
              subscription_id = "00000000-0000-0000-0000-000000000000" #existing subscription managed via Alias
            }  
          }
        }
      }
    }
  }
}
```

### Azure AD Groups integration
This module allows to create a set of Azure AD groups assigned to management scopes like: 
management groups and subscriptions. The default naming convention for Azure AD Group is:
`[name-of-the-management-unit]-[management-unit-type]-[name-of-the-group]`. 

```terraform
management_groups = {
  level_1_mgmt_group = {
    ad_groups = {
      security-readers = {
        role_names : [
          "Security Reader"
        ]
      }
    }
  }
}
```
The configuration above will create an AAD group named: `level_1_mgmt_group-mg-security-readers`. 
Users belonging to this group will have `Security Reader` role for the `level_1_mgmt_group` scope, 
which means they will have this set of permissions to all child resources 
(child management groups, subscriptions associated with this management group and Azure resources created in those subscriptions).

#### Default Azure AD groups
Instead of repeating the `ad_groups` block for each management unit, you can define a set of default AAD groups 
that can be created for particular management units. 

```terraform
default_ad_groups_for_resource_containers = {
  contributors = {
    role_names: ["Contributor"]
  }
  readers = {
    role_names: ["Reader"]
  }
}

management_groups = {
  level_1_mgmt_group = {
    create_default_ad_groups = true
  }
}
```
The configuration above will create an AAD groups named: `level_1_mgmt_group-mg-readers` and `level_1_mgmt_group-mg-contributors`.

The `default_ad_groups_for_resource_containers` option can be used in conjunction with the `ad_groups`, 
where `ad_groups` takes a precedence if there's a group name conflict.     

> The context object can drive the naming convention for the entire module, including the AAD groups naming.

## NOTES

This module only supports built-in Azure policies and built-in IAM roles for Azure AD groups integration.
You can only manage existing subscriptions. Support for creating subscriptions under Enterprise Agreement will be added in a near future.

## EXAMPLES

- [Cloud Adoption Framework management groups](examples/caf-mgmt-groups)
- [Full example](examples/full-example)

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_default_ad_groups_for_resource_containers"></a> [default\_ad\_groups\_for\_resource\_containers](#input\_default\_ad\_groups\_for\_resource\_containers) | Map of default AD groups that will be created for resource containers (management-group, subscription, resource-group) if enabled | <pre>map(object({<br>    role_names : list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_default_consumption_budget_notification_emails"></a> [default\_consumption\_budget\_notification\_emails](#input\_default\_consumption\_budget\_notification\_emails) | List of e-mail addresses that will be used for notifications if they were not provided explicitly | `list(string)` | `[]` | no |
| <a name="input_default_consumption_budgets_notifications"></a> [default\_consumption\_budgets\_notifications](#input\_default\_consumption\_budgets\_notifications) | Configuration of default notifications<br>    map(object({<br>      operator       = string<br>      threshold      = string<br>      threshold\_type = string<br>      contact\_emails = list(string)<br>    })) | <pre>map(object({<br>    operator       = string<br>    threshold      = string<br>    threshold_type = string<br>    contact_emails = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_management_groups"></a> [management\_groups](#input\_management\_groups) | Management Groups Tree layout with attached Azure Policies and subscriptions | `map(any)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_management_group_level_1"></a> [management\_group\_level\_1](#module\_management\_group\_level\_1) | ./modules/management-group | n/a |
| <a name="module_management_group_level_2"></a> [management\_group\_level\_2](#module\_management\_group\_level\_2) | ./modules/management-group | n/a |
| <a name="module_management_group_level_3"></a> [management\_group\_level\_3](#module\_management\_group\_level\_3) | ./modules/management-group | n/a |
| <a name="module_management_group_level_4"></a> [management\_group\_level\_4](#module\_management\_group\_level\_4) | ./modules/management-group | n/a |
| <a name="module_management_group_level_5"></a> [management\_group\_level\_5](#module\_management\_group\_level\_5) | ./modules/management-group | n/a |
| <a name="module_management_group_level_6"></a> [management\_group\_level\_6](#module\_management\_group\_level\_6) | ./modules/management-group | n/a |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ad_groups"></a> [ad\_groups](#output\_ad\_groups) | Map of all AD Groups created by this module flatten to one level |
| <a name="output_management_groups"></a> [management\_groups](#output\_management\_groups) | Map of Management Groups flatten to one level |
| <a name="output_subscriptions"></a> [subscriptions](#output\_subscriptions) | Map of Subscriptions flatten to one level |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |

## Resources

No resources.
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/terraform-azurerm-tenant-management/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-azurerm-tenant-management" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
