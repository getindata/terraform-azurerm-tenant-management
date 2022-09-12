/**
 * # Azure Subscription wrapper module
 *
 * This module is a wrapper of `getindata/subscription/azurerm` module,
 * which adds support for Azure AD groups.
 */

module "this_subscription" {
  source  = "getindata/subscription/azurerm"
  version = "1.0.1"
  context = module.this.context


  subscription_id     = var.subscription_id
  management_group_id = var.management_group_id
}

module "ad_groups" {
  source  = "getindata/group/azuread"
  version = "1.0.0"

  for_each = local.ad_groups

  context = module.this.context
  name    = each.key
  stage = (lookup(module.this.descriptors, "ad-group-subscription", null) == null
    ? join(module.this.delimiter, [module.this.name, "sub"])
  : module.this.stage)

  role_assignments = [for role_name in each.value.role_names : {
    scope     = module.this_subscription.subscription_resource_id
    role_name = role_name
  }]
}
