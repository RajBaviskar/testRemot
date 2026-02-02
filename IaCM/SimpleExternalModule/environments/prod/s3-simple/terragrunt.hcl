include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3-simple"
}

inputs = {
  bucket_name = "raj-prod-simple-bucket-${get_aws_account_id()}"
  environment = "prod"
}
