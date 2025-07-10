# Root configuration file

# Generate AWS provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = var.aws_region
}
EOF
}

# Common inputs that apply to all environments
inputs = {
  aws_region    = "us-east-1"
  instance_type = "t2.micro"
  ami           = "ami-05b10e08d247fb927"
}
