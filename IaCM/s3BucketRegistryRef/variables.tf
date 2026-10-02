variable "aws_region" {
  description = "AWS region for the bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
  default     = "raj-iacm-module-ref-bucket"
}

variable "environment" {
  description = "Environment name stored on the bucket tags"
  type        = string
  default     = "dev"
}
