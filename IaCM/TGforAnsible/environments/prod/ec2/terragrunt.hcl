include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  environment   = "prod"
  instance_type = "t2.micro"
}
