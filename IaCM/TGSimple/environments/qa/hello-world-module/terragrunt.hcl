include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//hello-world-module"
}

# Environment and module-specific variables
inputs = {
  environment = "QA Environment"
  module_name = "hello-world-module"
}
