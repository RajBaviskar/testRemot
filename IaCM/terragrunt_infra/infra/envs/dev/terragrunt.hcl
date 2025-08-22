# Environment-level configuration
# No include block here as region-level and module-level files directly include root terragrunt.hcl

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("variables.hcl"))
}

inputs = merge(
  local.env_vars.locals,
  {
    environment = "dev"
    cost_center = "1234"
  }
)
