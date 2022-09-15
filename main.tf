module "management_group_level_1" {
  source  = "./modules/management-group"
  context = module.this.context

  for_each = local.mgmt_group_level_1

  name                       = each.key
  display_name               = lookup(each.value, "display_name", title(lookup(each.value, "name", each.key)))
  parent_management_group_id = lookup(each.value, "parent_management_group_id", null)

  #Normalise the maps
  policies = { for k, v in lookup(each.value, "policies", {}) : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
  subscriptions = { for k, v in lookup(each.value, "subscriptions", {}) : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
  } }

  ad_groups                                 = lookup(each.value, "ad_groups", {})
  create_default_ad_groups                  = lookup(each.value, "create_default_ad_groups", false)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers
}

module "management_group_level_2" {
  source  = "./modules/management-group"
  context = module.this.context

  for_each = local.mgmt_group_level_2

  name                       = each.key
  display_name               = lookup(each.value, "display_name", title(lookup(each.value, "name", each.key)))
  parent_management_group_id = module.management_group_level_1[each.value.parent].management_group_id

  #Normalise the maps
  policies = { for k, v in lookup(each.value, "policies", {}) : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
  subscriptions = { for k, v in lookup(each.value, "subscriptions", {}) : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
  } }

  ad_groups                                 = lookup(each.value, "ad_groups", {})
  create_default_ad_groups                  = lookup(each.value, "create_default_ad_groups", false)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers
}

module "management_group_level_3" {
  source  = "./modules/management-group"
  context = module.this.context

  for_each = local.mgmt_group_level_3

  name                       = each.key
  display_name               = lookup(each.value, "display_name", title(lookup(each.value, "name", each.key)))
  parent_management_group_id = module.management_group_level_2[each.value.parent].management_group_id

  #Normalise the maps
  policies = { for k, v in lookup(each.value, "policies", {}) : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
  subscriptions = { for k, v in lookup(each.value, "subscriptions", {}) : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
  } }

  ad_groups                                 = lookup(each.value, "ad_groups", {})
  create_default_ad_groups                  = lookup(each.value, "create_default_ad_groups", false)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers
}

module "management_group_level_4" {
  source  = "./modules/management-group"
  context = module.this.context

  for_each = local.mgmt_group_level_4

  name                       = each.key
  display_name               = lookup(each.value, "display_name", title(lookup(each.value, "name", each.key)))
  parent_management_group_id = module.management_group_level_3[each.value.parent].management_group_id

  #Normalise the maps
  policies = { for k, v in lookup(each.value, "policies", {}) : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
  subscriptions = { for k, v in lookup(each.value, "subscriptions", {}) : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
  } }

  ad_groups                                 = lookup(each.value, "ad_groups", {})
  create_default_ad_groups                  = lookup(each.value, "create_default_ad_groups", false)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers
}

module "management_group_level_5" {
  source  = "./modules/management-group"
  context = module.this.context

  for_each = local.mgmt_group_level_5

  name                       = each.key
  display_name               = lookup(each.value, "display_name", title(lookup(each.value, "name", each.key)))
  parent_management_group_id = module.management_group_level_4[each.value.parent].management_group_id

  #Normalise the maps
  policies = { for k, v in lookup(each.value, "policies", {}) : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
  subscriptions = { for k, v in lookup(each.value, "subscriptions", {}) : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
  } }

  ad_groups                                 = lookup(each.value, "ad_groups", {})
  create_default_ad_groups                  = lookup(each.value, "create_default_ad_groups", false)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers
}

module "management_group_level_6" {
  source  = "./modules/management-group"
  context = module.this.context

  for_each = local.mgmt_group_level_6

  name                       = each.key
  display_name               = lookup(each.value, "display_name", title(lookup(each.value, "name", each.key)))
  parent_management_group_id = module.management_group_level_5[each.value.parent].management_group_id

  #Normalise the maps
  policies = { for k, v in lookup(each.value, "policies", {}) : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
  subscriptions = { for k, v in lookup(each.value, "subscriptions", {}) : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
  } }

  ad_groups                                 = lookup(each.value, "ad_groups", {})
  create_default_ad_groups                  = lookup(each.value, "create_default_ad_groups", false)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers
}
