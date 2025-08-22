include {
  path = "../../../../terragrunt.hcl"
}

terraform {
  # Using local module (for demo). In real use, point to your module repo.
  source = "../../../../modules/vpc"
}

# Enable VPC creation for dev environment
# skip = true

locals {
  env_vars = read_terragrunt_config("../../variables.hcl")
  region_vars = read_terragrunt_config("../variables.hcl")
}

inputs = merge(
  local.env_vars.locals,
  {
    cidr_block = local.region_vars.locals.vpc_cidr,
    environment = local.env_vars.locals.tags.environment,
    region = local.region_vars.locals.tags.region
  }
)
