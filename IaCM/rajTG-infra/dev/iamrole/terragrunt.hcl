include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/iamrole"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

inputs = {
  role_name = "dev-raj-ec2-role"
  s3_bucket = "dev-raj-seq-artifacts"
}
