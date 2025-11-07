include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/resource_group"
}

inputs = {
  name     = "raj-dev-rg"
  location = "eastus"
}
