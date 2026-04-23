# Root Terragrunt Configuration
# This file is referenced by child modules via find_in_parent_folders()

# Configure Terragrunt to automatically store tfstate files in S3
remote_state {
  backend = "s3"
  config = {
    bucket  = "rajtgoverrides6bucket"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate provider configuration that is common across all environments
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      ManagedBy = "Terragrunt"
    }
  }
}
EOF
}

# Terraform configuration
terraform {
  # Add extra arguments for commands
  extra_arguments "init_args" {
    commands = ["init"]
    arguments = [
      "-reconfigure"
    ]
  }

  extra_arguments "plan_args" {
    commands = ["plan"]
    arguments = [
      "-refresh=true"
    ]
  }
}
