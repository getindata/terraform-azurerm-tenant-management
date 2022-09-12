variable "subscriptions" {
  type = map(object({
    subscription_id : string
    create_default_ad_groups : bool
    ad_groups : map(object({
      role_names : list(string)
    }))
  }))
  description = "Map of subscription that will be created/managed within the management group"
  default     = {}
}

variable "ad_groups" {
  type = map(object({
    role_names : list(string)
  }))
  description = "List of AD groups with role names that will be created with the management group scope"
  default     = {}
}

variable "default_ad_groups_for_resource_containers" {
  type = map(object({
    role_names : list(string)
  }))
  description = "Map of default AD groups that will be created for the management group if enabled"
  default     = {}
}

variable "create_default_ad_groups" {
  type        = bool
  description = "Indicates wherever the default AD groups should be created for the management group"
  default     = false
}

###################################################
## Downstream management group module variables
###################################################

variable "display_name" {
  type        = string
  default     = null
  description = "A friendly name for this Management Group. If not specified, this will be the same as the name"
}

variable "parent_management_group_id" {
  type        = string
  description = "The ID of the Parent Management Group. If null, the management group will be provided under the Root Tenant management group"
  default     = null
}

variable "policies" {
  type = map(object({
    display_name : string
    enabled : bool
    parameters : any
  }))
  description = "Map of built-in Azure policies with respective parameters"
  default     = {}
}
