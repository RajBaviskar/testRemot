# string types
ami_id        = "ami-05b10e08d247fb927"
instance_type = "t2.micro"
instance_name = "raj-devspace-test"
bucket_name   = "raj-devspace-test-bucket"

# boolean type
enable_versioning = true

# number types
instance_count     = 2
max_retry_attempts = 5

# json/map type (use value_type=json in IaCM)
resource_tags = {
  "Environment" = "testing"
  "Team"        = "iacm"
  "ManagedBy"   = "terraform"
}

# json/object type (use value_type=json in IaCM)
instance_metadata = {
  environment = "staging"
  team        = "platform"
  cost_center = "eng-42"
}

# json/list type (use value_type=json in IaCM)
allowed_cidrs      = ["10.0.0.0/16", "172.16.0.0/12"]
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# complex json type (use value_type=json in IaCM)
scaling_config = {
  min_size     = 1
  max_size     = 10
  desired_size = 3
  policies = [
    {
      name       = "scale-up-cpu"
      threshold  = 75
      adjustment = 2
    },
    {
      name       = "scale-down-cpu"
      threshold  = 25
      adjustment = -1
    }
  ]
}
