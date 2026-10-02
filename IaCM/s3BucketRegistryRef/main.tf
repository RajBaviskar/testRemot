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
  region = var.aws_region
}

module "bucket" {
  source  = "saas-central-devspace.harness-test.com/W_2ikBWEQjeB0BqokV3lTQ/s3-bucket/aws"
  version = "1.1.0"

  bucket_name = var.bucket_name
  environment = var.environment
}

output "bucket_name" {
  value = module.bucket.bucket_name
}

output "bucket_arn" {
  value = module.bucket.bucket_arn
}
