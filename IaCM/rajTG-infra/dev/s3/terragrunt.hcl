include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/s3"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {}
}
EOF
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
  bucket_name = "dev-raj-seq-artifacts"
}
