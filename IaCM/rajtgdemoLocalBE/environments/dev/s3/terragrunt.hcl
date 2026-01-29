include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  environment = "dev"
  bucket_name = "raj-dev-bucket-local-be-2024"
  
  tags = {
    Owner   = "raj-dev-team"
    Project = "raj-tg-demo-local"
  }
}
