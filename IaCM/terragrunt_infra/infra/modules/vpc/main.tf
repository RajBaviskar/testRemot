terraform {
  backend "s3" {}
}

variable "cidr_block" {}
variable "tags" { type = map(string) }
variable "environment" {}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "raj-test-${var.environment}-vpc" })
}

output "vpc_id" {
  value = aws_vpc.this.id
}
