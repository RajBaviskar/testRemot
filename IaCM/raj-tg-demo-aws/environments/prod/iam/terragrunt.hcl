include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-user?version=5.34.0"
}

inputs = {
  name = "raj-prod-user"
  
  # Create access key
  create_iam_access_key = true
  
  # More restrictive policies for prod
  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
  
  # Custom inline policy
  create_iam_user_login_profile = false
  
  tags = {
    Environment = "prod"
    Project     = "raj-tg-demo"
    ManagedBy   = "terragrunt"
    Owner       = "raj-prod-team"
  }
}
