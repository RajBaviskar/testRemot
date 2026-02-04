include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3-wrapper"
}

inputs = {
  bucket_name = "raj-dev-wrapper-module-12345"
  environment = "dev"
}
