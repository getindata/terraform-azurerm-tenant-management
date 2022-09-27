locals {
  mgmt_group_level_1 = {
    for child_name, child in var.management_groups : child_name => {
      parent                   = null,
      name                     = child_name
      display_name             = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups        = lookup(child, "management_groups", {})
      subscriptions            = lookup(child, "subscriptions", {})
      policies                 = lookup(child, "policies", {})
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
  } }
  mgmt_group_level_2 = merge([
    for k, v in local.mgmt_group_level_1 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent                   = k,
      name                     = child_name
      display_name             = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups        = lookup(child, "management_groups", {})
      policies                 = lookup(child, "policies", {})
      subscriptions            = lookup(child, "subscriptions", {})
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_3 = merge([
    for k, v in local.mgmt_group_level_2 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent                   = k,
      name                     = child_name
      display_name             = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups        = lookup(child, "management_groups", {})
      policies                 = lookup(child, "policies", {})
      subscriptions            = lookup(child, "subscriptions", {})
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_4 = merge([
    for k, v in local.mgmt_group_level_3 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent                   = k,
      name                     = child_name
      display_name             = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups        = lookup(child, "management_groups", {})
      policies                 = lookup(child, "policies", {})
      subscriptions            = lookup(child, "subscriptions", {})
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_5 = merge([
    for k, v in local.mgmt_group_level_4 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent                   = k,
      name                     = child_name
      display_name             = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups        = lookup(child, "management_groups", {})
      policies                 = lookup(child, "policies", {})
      subscriptions            = lookup(child, "subscriptions", {})
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_6 = merge([
    for k, v in local.mgmt_group_level_5 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent                   = k,
      name                     = child_name
      display_name             = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups        = lookup(child, "management_groups", {})
      policies                 = lookup(child, "policies", {})
      subscriptions            = lookup(child, "subscriptions", {})
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
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
