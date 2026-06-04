include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  source = "../../modules/ec2"
}

inputs = {
  instance_name = "prod-app-server-1"
}
