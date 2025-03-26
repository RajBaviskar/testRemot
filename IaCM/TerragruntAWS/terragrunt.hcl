# Define local variables (if needed)
# locals {
#   environments = ["dev", "staging", "prod"]
# }

# Include configurations for environments and modules
# This will include the terragrunt.hcl configurations of individual environments
# include {
#   path = find_in_parent_folders()
# }

# Define configurations common to all environments (if any)
# terraform {
#   extra_arguments "common_vars" {
#     commands = get_terraform_commands_that_need_vars()
#     required_var_files = []
#   }
# }

# Include all submodules to run terragrunt on them
# This will enable running `terragrunt run-all init` from the root folder

# Include VPC submodule for dev environment
# include "vpc" {
#   path = "./environments/dev/vpc/terragrunt.hcl"
# }

# Include EC2 submodule for dev environment
# include "ec2" {
#   path = "./environments/dev/ec2/terragrunt.hcl"
# }
