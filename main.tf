module "management_group_level_1" {
  for_each = local.mgmt_group_level_1

  source  = "./modules/management-group"
  context = module.this.context

  parent_management_group_id                = lookup(each.value, "parent_management_group_id", null)
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers

  name                     = each.key
  display_name             = each.value.display_name
  policies                 = each.value.policies
  subscriptions            = each.value.subscriptions
  ad_groups                = each.value.ad_groups
  create_default_ad_groups = each.value.create_default_ad_groups

  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
  default_consumption_budgets_notifications      = var.default_consumption_budgets_notifications
}

module "management_group_level_2" {
  for_each = local.mgmt_group_level_2

  source  = "./modules/management-group"
  context = module.this.context

  parent_management_group_id                = module.management_group_level_1[each.value.parent].management_group_id
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers

  name                     = each.key
  display_name             = each.value.display_name
  policies                 = each.value.policies
  subscriptions            = each.value.subscriptions
  ad_groups                = each.value.ad_groups
  create_default_ad_groups = each.value.create_default_ad_groups

  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
  default_consumption_budgets_notifications      = var.default_consumption_budgets_notifications
}

module "management_group_level_3" {
  for_each = local.mgmt_group_level_3

  source  = "./modules/management-group"
  context = module.this.context

  parent_management_group_id                = module.management_group_level_2[each.value.parent].management_group_id
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers

  name                     = each.key
  display_name             = each.value.display_name
  policies                 = each.value.policies
  subscriptions            = each.value.subscriptions
  ad_groups                = each.value.ad_groups
  create_default_ad_groups = each.value.create_default_ad_groups

  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
  default_consumption_budgets_notifications      = var.default_consumption_budgets_notifications
}

module "management_group_level_4" {
  for_each = local.mgmt_group_level_4

  source  = "./modules/management-group"
  context = module.this.context

  parent_management_group_id                = module.management_group_level_3[each.value.parent].management_group_id
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers

  name                     = each.key
  display_name             = each.value.display_name
  policies                 = each.value.policies
  subscriptions            = each.value.subscriptions
  ad_groups                = each.value.ad_groups
  create_default_ad_groups = each.value.create_default_ad_groups

  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
  default_consumption_budgets_notifications      = var.default_consumption_budgets_notifications
}

module "management_group_level_5" {
  for_each = local.mgmt_group_level_5

  source  = "./modules/management-group"
  context = module.this.context

  parent_management_group_id                = module.management_group_level_4[each.value.parent].management_group_id
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers

  name                     = each.key
  display_name             = each.value.display_name
  policies                 = each.value.policies
  subscriptions            = each.value.subscriptions
  ad_groups                = each.value.ad_groups
  create_default_ad_groups = each.value.create_default_ad_groups

  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
  default_consumption_budgets_notifications      = var.default_consumption_budgets_notifications
}

module "management_group_level_6" {
  for_each = local.mgmt_group_level_6

  source  = "./modules/management-group"
  context = module.this.context

  parent_management_group_id                = module.management_group_level_5[each.value.parent].management_group_id
  default_ad_groups_for_resource_containers = local.default_ad_groups_for_resource_containers

  name                     = each.key
  display_name             = each.value.display_name
  policies                 = each.value.policies
  subscriptions            = each.value.subscriptions
  ad_groups                = each.value.ad_groups
  create_default_ad_groups = each.value.create_default_ad_groups

  default_consumption_budget_notification_emails = var.default_consumption_budget_notification_emails
  default_consumption_budgets_notifications      = var.default_consumption_budgets_notifications
}
