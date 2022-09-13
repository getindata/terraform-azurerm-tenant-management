variable "management_groups" {
  description = "Management Groups Tree layout with attached Azure Policies and subscriptions"
  type        = map(any)
  default     = {}
}

variable "default_ad_groups_for_resource_containers" {
  type = map(object({
    role_names : list(string)
  }))
  description = "Map of default AD groups that will be created for resource containers (management-group, subscription, resource-group) if enabled"
  default     = {}
}
