
terraform {
  source =  "../../../modules/ec2"
}

inputs = {
  ami_id         = "ami-05b10e08d247fb927"
  instance_type  = "t2.micro"
  instance_name  = "raj-prod-instance"
  aws_region    = "us-east-1"  # Set your desired AWS region here
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = "raj-tg"
    key            = "${path_relative_to_include()}/ec2/terraform.tfstate"
    region         = "us-east-1"  # Change to your AWS region
    encrypt        = true
  }
}
