provider "aws" {
  region = "us-east-1"
  # AWS credentials must still be provided via env vars, CLI profile, etc.
}

module "vpc" {
  source     = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v4.0.2"
  name       = "example-vpc"
  cidr       = "10.0.0.0/16"
  azs        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
}
