# Root terragrunt.hcl configuration
locals {
  # Default values - can be overridden via CLI -var flags
  common_vars = {
    owner       = "default-owner"
    environment = "dev"
    project     = "simple-tg"
  }
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
EOF
}

# Local state backend
remote_state {
  backend = "local"
  config = {
    path = "states/${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Common inputs for all modules - these will be passed as TF variables
inputs = {
  # These values can be overridden via CLI: terragrunt plan -var="owner=custom-owner"
}
