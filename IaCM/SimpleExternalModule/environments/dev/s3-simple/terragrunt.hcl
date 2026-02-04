include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3-simple"
}

inputs = {
  bucket_name = "raj-dev-simple-bucket-12345"
  environment = "dev"
}
