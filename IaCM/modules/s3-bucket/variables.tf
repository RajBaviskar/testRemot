variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment name stored on the bucket tags"
  type        = string
  default     = "dev"
}
