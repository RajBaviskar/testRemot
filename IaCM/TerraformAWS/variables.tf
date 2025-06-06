variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-05b10e08d247fb927"
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default = "raj-tf-ec2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "raj-tf-s3-bucket"
}
