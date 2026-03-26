variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


variable "ec2_instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
  default     = "dev-ec2-instance"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}
