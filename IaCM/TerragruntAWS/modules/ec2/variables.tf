variable "ami_id" {}
variable "instance_type" {}
variable "instance_name" {}
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}
