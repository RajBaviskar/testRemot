include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name       = "raj-qa-bucket-ai-demo"
  environment       = "qa"
  owner            = "qa-team"
  enable_versioning = true
}
