locals {
  # Local backend configuration
  backend_config = {
    path = "states/${path_relative_to_include()}/terraform.tfstate"
  }
}

# Generate backend configuration
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "local" {
    path = "${local.backend_config.path}"
  }
}
EOF
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

# Remote state configuration
remote_state {
  backend = "local"
  config  = local.backend_config
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
