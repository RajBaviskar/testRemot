# Include all settings from the root configuration file
include {
  path = find_in_parent_folders("root.hcl")
}

# Specify the terraform configuration source
terraform {
  source = "../../../modules/ec2"
}

# Override only the specific inputs that are different for this environment
inputs = {
  ami_id        = "ami-05b10e08d247fb927"
  instance_name = "raj-dev-instance"
  # Note: instance_type and aws_region are inherited from root configuration
}