include {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  region = "us-east-1"
}
