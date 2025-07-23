locals {
  terraform_version = "1.5.0"
}

remote_state {
  backend = "local"
  config = {}
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    harness = {
      source = "harness/harness"
      version = "~> 0.14"
    }
  }
}

provider "harness" {
  endpoint          = "${get_env("HARNESS_ENDPOINT")}"
  account_id        = "${get_env("HARNESS_ACCOUNT_ID")}"
  platform_api_key  = "${get_env("HARNESS_PLATFORM_API_KEY")}"
}
EOF
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}
