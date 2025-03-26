terraform {
  required_version = ">= 1.0"
}

# Assigning values directly
locals {
  ami_id        = "ami-05b10e08d247fb927"  # Replace with a valid AMI ID
  instance_name = "raj-tf-ec2"
}
