include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0"
}

inputs = {
  bucket = "raj-dev-external-module-${get_aws_account_id()}"
  
  versioning = {
    enabled = true
  }
  
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  
  tags = {
    Name        = "DevExternalModule"
    Environment = "dev"
    ManagedBy   = "Terragrunt"
    Type        = "ExternalModule"
  }
}
