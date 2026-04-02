# Root Terragrunt Configuration
locals {
  bucket_name = "rajtgcost"
}

# S3 Backend Configuration
remote_state {
  backend = "s3"

  config = {
    bucket         = local.bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate Provider Configuration
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
}
EOF
}

# Common inputs for all modules
inputs = {
  project     = "rajTGCost"
  managed_by  = "Terragrunt"
}
