terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "raj-tf-infra"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2" {
  source = "../modules/ec2"

  environment    = var.environment
  instance_type  = var.ec2_instance_type
  ami_id         = data.aws_ami.amazon_linux_2.id
  instance_name  = var.ec2_instance_name
}

module "s3" {
  source = "../modules/s3"

  environment   = var.environment
  bucket_name   = var.s3_bucket_name
}
