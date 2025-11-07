terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "demo" {
  ami           = "ami-0453ec754f44f9a4a"  # Amazon Linux 2023 in us-east-1
  instance_type = "t2.micro"
}

output "instance_id" {
  value = aws_instance.demo.id
}
