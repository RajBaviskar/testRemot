# Root configuration file

# Generate AWS provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = var.aws_region
}
EOF
}

# Remote state configuration for all child terragrunt.hcl files
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket          = "rajtgaws-new4"
    key             = "${path_relative_to_include()}/terraform.tfstate"
    region          = "us-east-1"
    encrypt         = true
  }
}

# Common inputs that apply to all environments
inputs = {
  aws_region     = "us-east-1"
  instance_type  = "t2.micro"  # Default instance type
}

# Common terraform configuration
terraform {
  # Force Terraform to keep trying to acquire a lock for
  # up to 20 minutes if someone else has the lock
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=20m"]
  }

  # Common variables for all commands
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}
