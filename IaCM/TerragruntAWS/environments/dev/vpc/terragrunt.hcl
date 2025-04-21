# Include all settings from the root configuration file
include {
  path = find_in_parent_folders("root.hcl")
}

# Specify the terraform configuration source
terraform {
  source = "../../../modules/vpc"
}

# Override only the specific inputs that are different for this environment
inputs = {
  cidr_block = "10.0.0.0/16"
  vpc_name   = "raj-dev-vpc"
  # Note: aws_region is inherited from root configuration
}