resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name = "example-bucket"
  }
}
