terraform {
  backend "s3" {}
}

variable "bucket_name" {}
variable "versioning" { type = bool }
variable "tags" { type = map(string) }
variable "environment" {}
variable "region" {}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = merge(var.tags, { Name = "${var.environment}-s3" })
}

# Use separate resource for ACL instead of the deprecated inline attribute
resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

# Use separate resource for versioning instead of the deprecated inline block
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Disabled"
  }
}
