locals {
  ad_groups = merge(
    var.create_default_ad_groups ? var.default_ad_groups_for_resource_containers : {},
    var.ad_groups
  )
  subscriptions = { for k, v in var.subscriptions : k => {
    subscription_id          = lookup(v, "subscription_id", null)
    create_default_ad_groups = lookup(v, "create_default_ad_groups", false)
    ad_groups                = lookup(v, "ad_groups", {})
    consumption_budgets = { for budget_name, budget in try(v.budgets, {}) : budget_name => {
      amount = budget.amount
      time_period = {
        start_date = can(budget.time_period) ? lookup(budget.time_period, "start_date", null) : null
        end_date   = can(budget.time_period) ? lookup(budget.time_period, "end_date", null) : null
      }
      #If default notification enabled, merge them with the provided ones
      notifications = { for notification_name, notification in merge(
        lookup(budget, "default_notifications_enabled", true) ? var.default_consumption_budgets_notifications : {}, lookup(budget, "notifications", {})
        ) : notification_name => merge(notification, {
          contact_emails = concat(var.default_consumption_budget_notification_emails, notification.contact_emails, lookup(budget, "default_contact_emails", []))
      }) }
    } }
  } }
  policies = { for k, v in var.policies : k => {
    display_name = lookup(v, "display_name", null)
    enabled      = lookup(v, "enabled", true)
    parameters   = lookup(v, "parameters", {})
  } }
}
