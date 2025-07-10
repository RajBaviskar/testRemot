terraform {
  source = "./hello-world-module"
}

# Generate remote state configuration
remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# No inputs needed for this simple hello world module
inputs = {
}
