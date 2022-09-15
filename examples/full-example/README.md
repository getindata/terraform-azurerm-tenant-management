# Full example

```terraform
module "this_azure_management" {
  source  = "../../"
  context = module.this.context

  default_ad_groups_for_resource_containers = {
    contributors = {
      role_names : ["Contributor"]
    }
    readers = {
      role_names : ["Reader"]
    }
  }

  management_groups = {
    level_1_mgmt_group = {
      ad_groups = {
        security-readers = {
          role_names : [
            "Security Reader"
          ]
        }
      }
      create_default_ad_groups = true
      policies = {
        allowed_locations = {
          display_name = "Allowed locations" #Built-in policy
          parameters = {
            listOfAllowedLocations = [
              "West Europe"
            ]
          }
        }
      }
      management_groups = {
        level_2_mgmt_group = {
          subscriptions = {
            pay-as-you-go-main = {
              create_default_ad_groups = true
              subscription_id          = "00000000-0000-0000-0000-000000000000" #existing subscription managed via Alias
            }
          }
        }
      }
    }
  }
}

```

## Usage

```shell
terraform init
terraform plan -out tfplan
terraform apply tfplan
```
