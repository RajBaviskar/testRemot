variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_type" {
  description = "Unused - declared to allow root-level override via run-all"
  type        = string
  default     = "t2.small"
}
