variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
