variable "cidr_block" {}
variable "vpc_name" {}
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}