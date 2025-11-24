terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}
