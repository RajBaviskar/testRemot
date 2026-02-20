include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  instance_count = 2
  instance_type  = "t2.small"
  environment    = "staging"
  owner         = "staging-team"
}
