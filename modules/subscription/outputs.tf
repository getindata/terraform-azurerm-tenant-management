output "ad_groups" {
  value       = module.ad_groups
  description = "Map of AD Groups scoped to this Management Group"
}

###################################################
## Downstream subscription module outputs
###################################################

output "alias_id" {
  value       = module.this_subscription.alias_id
  description = "Alias ID of the subscription"
}

output "subscription_resource_id" {
  value       = module.this_subscription.subscription_resource_id
  description = "Resource ID of the subscription"
}

output "subscription_id" {
  value       = module.this_subscription.subscription_id
  description = "ID of the subscription"
}

output "subscription_name" {
  value       = module.this_subscription.subscription_name
  description = "Name of the subscription"
}

output "subscription_id_after_refreshed_access_token" {
  value       = module.this_subscription.subscription_id_after_refreshed_access_token
  description = "Subscription ID, which can be used after the running service principal refreshed its access token"
}
