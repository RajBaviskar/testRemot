# EC2 instance module with variable support
variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "default-owner"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "simple-tg"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "S3 bucket name (not used in EC2 but allows CLI override compatibility)"
  type        = string
  default     = ""
}

variable "instance_count" { 
  type = number 
  default = 1
}
variable "tags" { 
  type = map(string) 
  default = {}
}
variable "region" { 
  default = "us-east-1" 
}
variable "vpc_id" { default = "" }
variable "use_default_vpc" { default = false }

locals {
  common_tags = {
    Owner       = var.owner
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terragrunt"
  }
  
  instance_name = "raj-${var.project}-${var.environment}-instance"
}

# Get the latest Amazon Linux 2 AMI if not specified
data "aws_ami" "amazon_linux" {
  count       = var.ami_id == "" ? 1 : 0
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

resource "aws_instance" "main" {
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux[0].id
  instance_type = var.instance_type

  tags = merge(local.common_tags, {
    Name = local.instance_name
  })
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_tags" {
  description = "Tags applied to the EC2 instance"
  value       = aws_instance.main.tags
}
