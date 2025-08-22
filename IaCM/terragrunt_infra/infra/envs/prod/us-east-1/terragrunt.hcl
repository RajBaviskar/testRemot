include {
  path = "../../../terragrunt.hcl"
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("variables.hcl"))
}

inputs = merge(
  local.region_vars.locals,
  {
    aws_region = "us-east-1"
  }
)
