include {
  path = "../../../../terragrunt.hcl"
}

terraform {
  source = "../../../../modules/ec2"
}

# Enable EC2 creation in prod/us-west-2 using default VPC
# skip = true

locals {
  env_vars = read_terragrunt_config("../../variables.hcl")
  region_vars = read_terragrunt_config("../variables.hcl")
}

inputs = merge(
  local.env_vars.locals,
  {
    instance_type = local.region_vars.locals.instance_type,
    instance_count = 2,
    environment = local.env_vars.locals.tags.environment,
    region = local.region_vars.locals.tags.region,
    use_default_vpc = true # Use the default VPC instead of a custom one
  }
)
