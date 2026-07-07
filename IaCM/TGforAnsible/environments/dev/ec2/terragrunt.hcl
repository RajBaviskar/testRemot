include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  environment   = "dev"
  instance_type = "t2.micro"
}
