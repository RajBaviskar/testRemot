# Production environment S3 configuration
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  environment = "production"
  owner       = "prod-team"
  project     = "enterprise-app"
  bucket_name = "raj-prod-bucket-default"
}
