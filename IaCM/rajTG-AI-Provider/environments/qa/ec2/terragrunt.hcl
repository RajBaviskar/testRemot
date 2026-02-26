include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2-simple"
}

inputs = {
  instance_count = 1
  instance_type  = "t2.small"
  environment    = "qa"
  owner          = "qa-team"
}
