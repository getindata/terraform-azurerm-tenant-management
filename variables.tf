variable "management_groups" {
  description = "Management Groups Tree layout with attached Azure Policies and subscriptions"
  type        = map(any)
  default     = {}
}

variable "default_ad_groups_for_resource_containers" {
  description = "Map of default AD groups that will be created for resource containers (management-group, subscription, resource-group) if enabled"
  type = map(object({
    role_names : list(string)
  }))
  default = {}
}

variable "default_consumption_budgets_notifications" {
  description = <<EOT
    Configuration of default notifications
    map(object({
      operator       = string
      threshold      = string
      threshold_type = string
      contact_emails = list(string)
    }))
  EOT
  type = map(object({
    operator       = string
    threshold      = string
    threshold_type = string
    contact_emails = list(string)
  }))
  default = {}
}

variable "default_consumption_budget_notification_emails" {
  description = "List of e-mail addresses that will be used for notifications if they were not provided explicitly"
  type        = list(string)
  default     = []
}
