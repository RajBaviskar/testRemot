terraform {
  source = "../../modules/ec2"
}

inputs = {
  ami_id         = "ami-05b10e08d247fb927"
  instance_type  = "t2.micro"
  instance_name  = "dev-instance"
  aws_region    = "us-east-1"  # Set your desired AWS region here
}
