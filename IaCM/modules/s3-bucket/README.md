# s3-bucket

Creates an S3 bucket with versioning and AES256 server-side encryption.

## Usage

```hcl
module "bucket" {
  source  = "saas-central-devspace.harness-test.com/<account>/s3-bucket/aws"
  version = "1.2.0"

  bucket_name = "example-bucket"
  environment = "dev"
}
```

## Inputs

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | --- |
| bucket_name | Globally unique S3 bucket name | string | — | yes |
| environment | Environment name stored on the bucket tags | string | `dev` | no |

## Outputs

| Name | Description |
| --- | --- |
| bucket_name | Name of the S3 bucket |
| bucket_arn | ARN of the S3 bucket |
