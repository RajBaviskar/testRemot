include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Reference to external module from Terraform Registry with version pinning
terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0"
}

inputs = {
  bucket = "raj-external-ref-12345"
  
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
    Name        = "ExternalModuleRef"
    Environment = "dev"
    ManagedBy   = "Terragrunt"
    Type        = "ExternalModuleWithVersion"
  }
}
