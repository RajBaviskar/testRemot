include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/s3"
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
  bucket_name = "dev-raj-seq-artifacts"
}
