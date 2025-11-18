locals {
  vpc_cidr      = "10.0.0.0/16"
  instance_type = "t3.large"
  tags = {
    region = "us-east-1"
  }
}
