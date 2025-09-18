# Development environment S3 configuration
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name = "raj-tgoverride-dev-s3-bucket-20250918"
}
