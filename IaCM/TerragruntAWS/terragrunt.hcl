# Root terragrunt.hcl
locals {
  environments = ["dev", "staging", "prod"]
}

# Initialize all environments and modules
# include {
#   path = find_in_parent_folders()
# }

# Define configurations common to all environments
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = []
  }
}

# For running `terragrunt run-all init` in the root folder
# This will initialize all the environments in the `environments/` folder
