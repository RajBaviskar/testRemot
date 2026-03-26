include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/ec2"
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
  instance_type  = "t3.micro"
  instance_name  = "dev-ec2-server"
  environment    = "dev"
}
