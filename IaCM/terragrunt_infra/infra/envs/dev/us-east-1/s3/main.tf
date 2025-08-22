variable "bucket_name" {}
variable "versioning" { type = bool }
variable "tags" { type = map(string) }
variable "environment" {}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = var.versioning
  }

  tags = merge(var.tags, { Name = "${var.environment}-s3" })
}
