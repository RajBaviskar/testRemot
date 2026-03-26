locals {
  state_bucket    = "raj-tg-infra-prod2-state"
  state_region    = "us-east-1"
  dynamodb_table  = "tg-infra-prod2-lock"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = local.state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.state_region
    dynamodb_table = local.dynamodb_table
    encrypt        = true
  }
}
