terraform {
  source = "../../../modules/vpc"
}

inputs = {
  aws_region    = "us-east-1"  # Set your desired AWS region here
  cidr_block    = "10.0.0.0/16"
  vpc_name      = "raj-dev-vpc"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = "raj-tg"
    key            = "${path_relative_to_include()}/vpc/terraform.tfstate"
    region         = "us-east-1"  # Change to your AWS region
    encrypt        = true
  }
}