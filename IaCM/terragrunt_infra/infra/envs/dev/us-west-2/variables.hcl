locals {
  vpc_cidr      = "10.1.0.0/16"
  instance_type = "t3.small"
  tags = {
    region = "us-west-2"
  }
}
