locals {
  mgmt_group_level_1 = {
    for k, v in var.management_groups : k => merge({ parent = null, name = k }, v)
  }
  mgmt_group_level_2 = merge([
    for k, v in local.mgmt_group_level_1 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => merge({ parent = k, name = child_name }, child) }
  ]...)
  mgmt_group_level_3 = merge([
    for k, v in local.mgmt_group_level_2 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => merge({ parent = k, name = child_name }, child) }
  ]...)
  mgmt_group_level_4 = merge([
    for k, v in local.mgmt_group_level_3 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => merge({ parent = k, name = child_name }, child) }
  ]...)
  mgmt_group_level_5 = merge([
    for k, v in local.mgmt_group_level_4 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => merge({ parent = k, name = child_name }, child) }
  ]...)
  mgmt_group_level_6 = merge([
    for k, v in local.mgmt_group_level_5 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => merge({ parent = k, name = child_name }, child) }
  ]...)

  default_ad_groups_for_resource_containers = merge({
    contributors = {
      role_names = ["Contributor"]
    }
    readers = {
      role_names = ["Reader"]
    }
  }, var.default_ad_groups_for_resource_containers)
}
