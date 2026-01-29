include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Generate backend configuration for external module
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-user?version=5.34.0"
}

inputs = {
  name = "raj-dev-user"
  
  # Create access key
  create_iam_access_key = true
  
  # Attach policies
  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
  
  # Custom inline policy
  create_iam_user_login_profile = false
  
  tags = {
    Environment = "dev"
    Project     = "raj-tg-demo"
    ManagedBy   = "terragrunt"
    Owner       = "raj-dev-team"
  }
}
