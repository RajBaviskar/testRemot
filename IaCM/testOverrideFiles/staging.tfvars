# Staging environment variables
owner = "raj-staging-owner-override-from-files"
environment = "staging"
project = "simple-tg-override-from-files"
instance_type = "t3.small"
# bucket_name removed - let each environment use its own unique bucket name from terragrunt.hcl
aws_region = "us-west-2"
