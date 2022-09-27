/**
 * # Azure Subscription wrapper module
 *
 * This module is a wrapper of `getindata/subscription/azurerm` module,
 * which adds support for Azure AD groups.
 */

module "this_subscription" {
  source  = "getindata/subscription/azurerm"
  version = "1.1.0"
  context = module.this.context


  subscription_id     = var.subscription_id
  management_group_id = var.management_group_id

  billing_enrollment_account_scope               = var.billing_enrollment_account_scope
  refresh_token                                  = var.refresh_token
  diagnostics_log_analytics_workspace_id         = var.diagnostics_log_analytics_workspace_id
  diagnostics_categories_flag_map                = var.diagnostics_categories_flag_map
  consumption_budgets                            = var.consumption_budgets
  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
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
