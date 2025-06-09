terraform {
  required_version = ">= 1.0"
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
backend "s3" {
    bucket = "rajtfbasic-local1"  # Your S3 bucket
    key    = "SimpleTF/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    # Optional: Add DynamoDB table for state locking
    dynamodb_table = "terraform-locks"
}
}



resource "local_file" "example" {
  content  = "Hello from Terraform!"
  filename = "${path.module}/example.txt"
}

output "file_content" {
  value = local_file.example.content
}
