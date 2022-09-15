output "management_groups" {
  value = merge(
    module.management_group_level_1,
    module.management_group_level_2,
    module.management_group_level_3,
    module.management_group_level_4,
    module.management_group_level_5,
    module.management_group_level_6,
  )
  description = "Map of Management Groups flatten to one level"
}

output "subscriptions" {
  value = merge(
    merge([
      for k, v in module.management_group_level_1 : { for sub_name, subscription in v.subscriptions : "${k}-${sub_name}" => subscription }
    ]...),
    merge([
      for k, v in module.management_group_level_2 : { for sub_name, subscription in v.subscriptions : "${k}-${sub_name}" => subscription }
    ]...),
    merge([
      for k, v in module.management_group_level_3 : { for sub_name, subscription in v.subscriptions : "${k}-${sub_name}" => subscription }
    ]...),
    merge([
      for k, v in module.management_group_level_4 : { for sub_name, subscription in v.subscriptions : "${k}-${sub_name}" => subscription }
    ]...),
    merge([
      for k, v in module.management_group_level_5 : { for sub_name, subscription in v.subscriptions : "${k}-${sub_name}" => subscription }
    ]...),
    merge([
      for k, v in module.management_group_level_6 : { for sub_name, subscription in v.subscriptions : "${k}-${sub_name}" => subscription }
    ]...),
  )
  description = "Map of Subscriptions flatten to one level"
}

output "ad_groups" {
  value = merge(
    merge([
      for k, v in module.management_group_level_1 : { for group_name, group in v.ad_groups : "${k}-mg-${group_name}" => group }
    ]...),
    merge([
      for k, v in module.management_group_level_1 : merge([for sub_name, subscription in v.subscriptions : { for group_name, group in subscription.ad_groups : "${k}-${sub_name}-sub-${group_name}" => group }]...)
    ]...),
    merge([
      for k, v in module.management_group_level_2 : { for group_name, group in v.ad_groups : "${k}-mg-${group_name}" => group }
    ]...),
    merge([
      for k, v in module.management_group_level_2 : merge([for sub_name, subscription in v.subscriptions : { for group_name, group in subscription.ad_groups : "${k}-${sub_name}-sub-${group_name}" => group }]...)
    ]...),
    merge([
      for k, v in module.management_group_level_3 : { for group_name, group in v.ad_groups : "${k}-mg-${group_name}" => group }
    ]...),
    merge([
      for k, v in module.management_group_level_3 : merge([for sub_name, subscription in v.subscriptions : { for group_name, group in subscription.ad_groups : "${k}-${sub_name}-sub-${group_name}" => group }]...)
    ]...),
    merge([
      for k, v in module.management_group_level_4 : { for group_name, group in v.ad_groups : "${k}-mg-${group_name}" => group }
    ]...),
    merge([
      for k, v in module.management_group_level_4 : merge([for sub_name, subscription in v.subscriptions : { for group_name, group in subscription.ad_groups : "${k}-${sub_name}-sub-${group_name}" => group }]...)
    ]...),
    merge([
      for k, v in module.management_group_level_5 : { for group_name, group in v.ad_groups : "${k}-mg-${group_name}" => group }
    ]...),
    merge([
      for k, v in module.management_group_level_5 : merge([for sub_name, subscription in v.subscriptions : { for group_name, group in subscription.ad_groups : "${k}-${sub_name}-sub-${group_name}" => group }]...)
    ]...),
    merge([
      for k, v in module.management_group_level_6 : { for group_name, group in v.ad_groups : "${k}-mg-${group_name}" => group }
    ]...),
    merge([
      for k, v in module.management_group_level_6 : merge([for sub_name, subscription in v.subscriptions : { for group_name, group in subscription.ad_groups : "${k}-${sub_name}-sub-${group_name}" => group }]...)
    ]...),
  )
  description = "Map of all AD Groups created by this module flatten to one level"
}
