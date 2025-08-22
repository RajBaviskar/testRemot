terraform {
  backend "s3" {}
}

variable "instance_type" {}
variable "instance_count" { type = number }
variable "tags" { type = map(string) }
variable "environment" {}
variable "region" {}
variable "vpc_id" { default = "" }
variable "use_default_vpc" { default = false }

# Find the default VPC if needed
data "aws_vpc" "default" {
  count = var.use_default_vpc ? 1 : 0
  default = true
}

# Find subnets in the provided VPC or default VPC
data "aws_subnets" "available" {
  count = var.use_default_vpc || var.vpc_id != "" ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [var.use_default_vpc ? data.aws_vpc.default[0].id : var.vpc_id]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count         = var.instance_count
  subnet_id     = length(var.use_default_vpc || var.vpc_id != "" ? data.aws_subnets.available[0].ids : []) > 0 ? data.aws_subnets.available[0].ids[0] : null
  
  # Force the Name tag to always have the raj prefix
  tags = {
    Name = "raj-${var.environment}-ec2-${count.index}"
    environment = var.environment
    # Include any other tags from var.tags except Name
    for key, value in var.tags : key => value if key != "Name"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
