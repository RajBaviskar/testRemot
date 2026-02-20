include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name       = "raj-staging-bucket-ai-demo"
  environment       = "staging"
  owner            = "staging-team"
  enable_versioning = true
}
