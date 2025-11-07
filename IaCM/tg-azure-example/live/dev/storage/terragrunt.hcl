include "root" {
  path = find_in_parent_folders()
}

dependency "rg" {
  config_path = "../rg"
  mock_outputs = {
    name = "temp-rg"
  }
}

terraform {
  source = "../../../modules/storage_account"
}

inputs = {
  name                = "rajdevstorage12345"
  resource_group_name = dependency.rg.outputs.name
  location            = "eastus"
}
