# Define common variables
locals {
  module_name = "hello-world-module"
}

# Configure Terragrunt to automatically store tfstate files in a root-relative location
remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate providers and backend configuration that is common across all environments
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 0.12"
}
EOF
}

# Root level configuration
terraform {
  source = "./modules//hello-world-module"
  
  # Add extra arguments for init
  extra_arguments "init_reconfigure" {
    commands = ["init"]
    arguments = ["-reconfigure"]
  }
}

# Root level inputs
inputs = {
  environment = "root"
  module_name = local.module_name
}