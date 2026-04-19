# Root terragrunt.hcl configuration
locals {
  # Default values - can be overridden via CLI -var flags
  common_vars = {
    owner       = "default-owner"
    environment = "dev"
    project     = "simple-tg"
  }
}

# Add terraform block to force root to be treated as a module
terraform {
  source = "."
}

# Generate provider configuration - DISABLED TO TRIGGER ERROR
# generate "provider" {
#   path      = "provider.tf"
#   if_exists = "overwrite_terragrunt"
#   contents  = <<EOF
# provider "aws" {
#   region = "us-east-1"
# }
#
# terraform {
#   required_version = ">= 1.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }
# EOF
# }

# Local backend - DISABLED TO TRIGGER ERROR
# remote_state {
#   backend = "local"
#   config = {
#     path = "${get_terragrunt_dir()}/terraform.tfstate"
#   }
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
# }

# Common inputs for all modules - these will be passed as TF variables
inputs = {
  # Default values that can be overridden via CLI: terragrunt plan -var="owner=custom-owner"
  owner       = local.common_vars.owner
  environment = local.common_vars.environment
  project     = local.common_vars.project
}
