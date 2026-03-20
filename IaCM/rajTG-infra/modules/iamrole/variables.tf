variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "s3_bucket" {
  description = "Name of the S3 bucket to grant access to"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}
