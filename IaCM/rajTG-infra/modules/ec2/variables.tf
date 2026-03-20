variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role to attach to EC2 instance"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}
