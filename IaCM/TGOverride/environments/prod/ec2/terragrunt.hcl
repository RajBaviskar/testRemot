# Production environment EC2 configuration
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  environment   = "production"
  owner         = "prod-team"
  project       = "enterprise-app"
  instance_type = "t3.small"
  bucket_name   = "raj-prod-bucket-default"
}
