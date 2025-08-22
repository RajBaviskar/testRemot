include {
  path = "../../../../terragrunt.hcl"
}

terraform {
  source = "../../../../modules/ec2"
}

# No dependency on VPC since we're using default VPC
# dependency "vpc" {
#   config_path = "../vpc"
#   mock_outputs = {
#     vpc_id = "mock-vpc-id"
#   }
#   mock_outputs_allowed_terraform_commands = ["validate", "plan", "destroy"]
# }

locals {
  env_vars = read_terragrunt_config("../../variables.hcl")
  region_vars = read_terragrunt_config("../variables.hcl")
}

inputs = merge(
  local.env_vars.locals,
  {
    instance_type = local.region_vars.locals.instance_type,
    instance_count = 1,
    environment = local.env_vars.locals.tags.environment,
    region = local.region_vars.locals.tags.region,
    use_default_vpc = true
  }
)
