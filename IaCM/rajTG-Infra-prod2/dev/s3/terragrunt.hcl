include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/s3"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

inputs = {
  bucket_name = "raj-dev-app-bucket-prod2"
  environment = "dev"
}
