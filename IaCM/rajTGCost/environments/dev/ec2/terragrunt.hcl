include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  environment     = "dev"
  region          = "us-east-1"
  instance_type   = "t3.large"  # Costs ~$0.0416/hour (~$30/month)
}
