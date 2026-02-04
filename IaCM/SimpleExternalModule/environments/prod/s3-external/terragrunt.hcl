include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0"
}

inputs = {
  bucket = "raj-prod-external-module-12345"
  
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
    Name        = "ProdExternalModule"
    Environment = "prod"
    ManagedBy   = "Terragrunt"
    Type        = "ExternalModule"
  }
}
