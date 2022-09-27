/**
 * # Azure Management Group wrapper module
 *
 * This module is a wrapper of `getindata/management-group/azurerm` module,
 * which adds support for Azure AD groups and is able to manage subscription under the management group it creates.
 */

data "azurerm_policy_definition" "this" {
  for_each = var.policies

  display_name = each.value.display_name
}

module "this_management_group" {
  source  = "getindata/management-group/azurerm"
  version = "1.0.1"

  context = module.this.context

  display_name               = var.display_name
  parent_management_group_id = var.parent_management_group_id

  management_group_policies = {
    for assignment_name, policy in local.policies : assignment_name => {
      policy_definition_id = data.azurerm_policy_definition.this[assignment_name].id
      parameters = { for param_name, param_value in lookup(policy, "parameters", {}) : param_name => {
        value = param_value
      } }
    }
    if lookup(policy, "enabled", true)
  }

  subscription_ids = [for subscription in module.subscription : subscription.subscription_id]
}

module "subscription" {
  source  = "../subscription"
  context = module.this.context

  for_each = local.subscriptions

  name = each.key

  subscription_id = each.value.subscription_id

  ad_groups                                 = each.value.ad_groups
  create_default_ad_groups                  = each.value.create_default_ad_groups
  default_ad_groups_for_resource_containers = var.default_ad_groups_for_resource_containers

  consumption_budgets = each.value.consumption_budgets
}

module "ad_groups" {
  source  = "getindata/group/azuread"
  version = "1.0.0"

  for_each = local.ad_groups

  context = module.this.context
  name    = each.key
  stage = (lookup(module.this.descriptors, "ad-group-management-group", null) == null
    ? join(module.this.delimiter, [module.this.name, "mg"])
  : module.this.stage)

  role_assignments = [for role_name in each.value.role_names : {
    scope     = module.this_management_group.management_group_id
    role_name = role_name
  }]
}
