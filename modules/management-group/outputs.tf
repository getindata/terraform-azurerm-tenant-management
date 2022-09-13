output "ad_groups" {
  value       = module.ad_groups
  description = "Map of AD Groups scoped to this Management Group"
}

output "subscriptions" {
  value       = module.subscription
  description = "Map of subscriptions associated with the management group"
}

###################################################
## Downstream management group module outputs
###################################################

output "management_group_id" {
  value       = module.this_management_group.management_group_id
  description = "The ID of the Management Group"
}

output "management_group_name" {
  value       = module.this_management_group.management_group_name
  description = "The name of the Management Group"
}

output "management_group_parent_management_group_id" {
  value       = module.this_management_group.management_group_parent_management_group_id
  description = "The ID of the parent Management Group"
}
