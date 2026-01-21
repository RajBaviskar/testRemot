include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  region      = "us-east-1"
  bucket_name = "raj-tg-demo-dev-bucket"
}
