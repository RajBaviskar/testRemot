include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  aws_region    = "us-east-1"
  instance_name = "ec2-cd-play"
}
