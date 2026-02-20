include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name       = "raj-prod-bucket-ai-demo"
  environment       = "prod"
  owner            = "prod-team"
  enable_versioning = true
}
