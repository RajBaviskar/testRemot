include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/ec2"
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
  instance_type  = "t2.small"
  iam_role_name  = "dev-raj-ec2-role-new"
}
