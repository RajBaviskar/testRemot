# Development environment EC2 configuration
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  environment   = "development"
  # MISSING VARIABLE TEST: Removed owner to trigger REQUIRED_FIELD_MISSING
  project       = "simple-tg"
  instance_type = "t2.small"
  bucket_name   = "raj-dev-bucket-default"
  db_password   = "DevPassword123!"
}
