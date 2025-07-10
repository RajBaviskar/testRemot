# Define common variables
locals {
  module_name = "hello-world-module"
  # Define state path based on environment and module
  state_file_path = "states/${path_relative_to_include()}/terraform.tfstate"
}

# Configure Terragrunt to automatically store tfstate files in a root-relative location
remote_state {
  backend = "local"
  config = {
    path = local.state_file_path
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
  
  # Add extra arguments for clean state handling in CI/CD
  extra_arguments "init_args" {
    commands = ["init"]
    arguments = [
      "-reconfigure"  # Always reconfigure to ensure clean state
    ]
  }

  extra_arguments "plan_args" {
    commands = ["plan"]
    arguments = [
      "-refresh=true"  # Always refresh state
    ]
  }
}

# Root level inputs
inputs = {
  environment = "root"
  module_name = local.module_name
}