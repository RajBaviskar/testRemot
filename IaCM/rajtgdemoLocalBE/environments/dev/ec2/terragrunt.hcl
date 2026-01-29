include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  environment   = "dev"
  instance_type = "t3.micro"
  
  tags = {
    Owner   = "raj-dev-team"
    Project = "raj-tg-demo-local"
  }
}
