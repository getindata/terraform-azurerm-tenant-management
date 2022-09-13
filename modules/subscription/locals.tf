locals {
  ad_groups = merge(
    var.create_default_ad_groups ? var.default_ad_groups_for_resource_containers : {},
    var.ad_groups
  )
}
