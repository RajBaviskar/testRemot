locals {
  bucket_name = get_env("TG_BUCKET_NAME")
}

remote_state {
  backend = "s3"

  config = {
    bucket         = local.bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

inputs = {}
