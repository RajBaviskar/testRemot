# remote_state {
#   backend = "azurerm"
#
#   config = {
#     resource_group_name  = "tg-state-rg"
#     storage_account_name = "tgstatebackend123"
#     container_name       = "tfstate"
#     key                  = "${path_relative_to_include()}/terraform.tfstate"
#   }
# }

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = "d4cb4169-4374-4b0f-9e30-ecd8203edb03"  # iacm-azure-play
}
EOF
}
