# Wrapper module that CALLS an external module
# This will create modules.json

module "s3_external" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"

  bucket = var.bucket_name

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
    Name        = "WrapperModuleRef"
    Environment = "dev"
    ManagedBy   = "Terragrunt"
    Type        = "WrapperCallingExternal"
  }
}

output "bucket_id" {
  value = module.s3_external.s3_bucket_id
}

output "bucket_arn" {
  value = module.s3_external.s3_bucket_arn
}
