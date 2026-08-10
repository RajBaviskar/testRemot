resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.resource_tags, {
    Name = "${var.instance_name}-${count.index}"
  })
}

# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = merge(var.resource_tags, {
    Name = "example-bucket"
  })
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

# S3 Bucket for import
resource "aws_s3_bucket" "testexample" {
  bucket = "raj-test-import"
}
