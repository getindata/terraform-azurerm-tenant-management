locals {
  mgmt_group_level_1 = {
    for child_name, child in var.management_groups : child_name => {
      parent            = null,
      name              = child_name
      display_name      = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups = lookup(child, "management_groups", {})
      policies = { for k, v in lookup(child, "policies", {}) : k => {
        display_name = lookup(v, "display_name", null)
        enabled      = lookup(v, "enabled", true)
        parameters   = lookup(v, "parameters", {})
      } }
      subscriptions = { for k, v in lookup(child, "subscriptions", {}) : k => {
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
              contact_emails = concat(notification.contact_emails, lookup(budget, "default_contact_emails", []), )
          }) }
        } }
      } }
      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
  } }
  mgmt_group_level_2 = merge([
    for k, v in local.mgmt_group_level_1 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent            = k,
      name              = child_name
      display_name      = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups = lookup(child, "management_groups", {})
      policies = { for k, v in lookup(child, "policies", {}) : k => {
        display_name = lookup(v, "display_name", null)
        enabled      = lookup(v, "enabled", true)
        parameters   = lookup(v, "parameters", {})
      } }
      subscriptions = { for k, v in lookup(child, "subscriptions", {}) : k => {
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
              contact_emails = concat(notification.contact_emails, lookup(budget, "default_contact_emails", []), )
          }) }
        } }
      } }

      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_3 = merge([
    for k, v in local.mgmt_group_level_2 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent            = k,
      name              = child_name
      display_name      = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups = lookup(child, "management_groups", {})
      policies = { for k, v in lookup(child, "policies", {}) : k => {
        display_name = lookup(v, "display_name", null)
        enabled      = lookup(v, "enabled", true)
        parameters   = lookup(v, "parameters", {})
      } }
      subscriptions = { for k, v in lookup(child, "subscriptions", {}) : k => {
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
              contact_emails = concat(notification.contact_emails, lookup(budget, "default_contact_emails", []), )
          }) }
        } }
      } }

      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_4 = merge([
    for k, v in local.mgmt_group_level_3 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent            = k,
      name              = child_name
      display_name      = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups = lookup(child, "management_groups", {})
      policies = { for k, v in lookup(child, "policies", {}) : k => {
        display_name = lookup(v, "display_name", null)
        enabled      = lookup(v, "enabled", true)
        parameters   = lookup(v, "parameters", {})
      } }
      subscriptions = { for k, v in lookup(child, "subscriptions", {}) : k => {
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
              contact_emails = concat(notification.contact_emails, lookup(budget, "default_contact_emails", []), )
          }) }
        } }
      } }

      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_5 = merge([
    for k, v in local.mgmt_group_level_4 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent            = k,
      name              = child_name
      display_name      = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups = lookup(child, "management_groups", {})
      policies = { for k, v in lookup(child, "policies", {}) : k => {
        display_name = lookup(v, "display_name", null)
        enabled      = lookup(v, "enabled", true)
        parameters   = lookup(v, "parameters", {})
      } }
      subscriptions = { for k, v in lookup(child, "subscriptions", {}) : k => {
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
              contact_emails = concat(notification.contact_emails, lookup(budget, "default_contact_emails", []), )
          }) }
        } }
      } }

      ad_groups                = lookup(child, "ad_groups", {})
      create_default_ad_groups = lookup(child, "create_default_ad_groups", false)
    } }
  ]...)
  mgmt_group_level_6 = merge([
    for k, v in local.mgmt_group_level_5 : { for child_name, child in lookup(v, "management_groups", {}) : "${k}-${child_name}" => {
      parent            = k,
      name              = child_name
      display_name      = lookup(child, "display_name", title(lookup(child, "name", child_name)))
      management_groups = lookup(child, "management_groups", {})
      policies = { for k, v in lookup(child, "policies", {}) : k => {
        display_name = lookup(v, "display_name", null)
        enabled      = lookup(v, "enabled", true)
        parameters   = lookup(v, "parameters", {})
      } }
      subscriptions = { for k, v in lookup(child, "subscriptions", {}) : k => {
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
              contact_emails = concat(notification.contact_emails, lookup(budget, "default_contact_emails", []), )
          }) }
        } }
      } }

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
