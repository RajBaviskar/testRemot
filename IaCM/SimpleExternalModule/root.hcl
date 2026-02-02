locals {
  state_dir = "${get_repo_root()}/IaCM/SimpleExternalModule/states"
}

# Configure local backend
remote_state {
  backend = "local"
  
  config = {
    path = "${local.state_dir}/${path_relative_to_include()}/terraform.tfstate"
  }
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
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
