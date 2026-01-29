remote_state {
  backend = "local"
  
  config = {
    path = "${get_parent_terragrunt_dir()}/states/${path_relative_to_include()}/terraform.tfstate"
  }
}

inputs = {
  region = "us-east-1"
}
