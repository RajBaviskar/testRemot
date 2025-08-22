include {
  path = "../../../../terragrunt.hcl"
}

terraform {
  source = "../../../../modules/s3"
}

locals {
  env_vars = read_terragrunt_config("../../variables.hcl")
  region_vars = read_terragrunt_config("../variables.hcl")
}

inputs = merge(
  local.env_vars.locals,
  {
    bucket_name = "raj-test-${local.env_vars.locals.tags.environment}-us-west-2-bucket",
    environment = local.env_vars.locals.tags.environment,
    versioning = true,
    region = local.region_vars.locals.tags.region
  }
)
