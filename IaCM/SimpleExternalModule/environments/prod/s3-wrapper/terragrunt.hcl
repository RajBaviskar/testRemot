include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3-wrapper"
}

inputs = {
  bucket_name = "raj-prod-wrapper-module-${get_aws_account_id()}"
  environment = "prod"
}
