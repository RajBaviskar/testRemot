terraform {
  required_version = ">= 1.0"
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}

resource "local_file" "example" {
  content  = "Hello from Terraform!"
  filename = "${path.module}/example.txt"
}

output "file_content" {
  value = local_file.example.content
}
