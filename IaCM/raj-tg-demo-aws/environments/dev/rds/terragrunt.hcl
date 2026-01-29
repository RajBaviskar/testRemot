include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Generate backend configuration for external module
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

# Generate provider configuration for external module
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

terraform {
  source = "tfr:///terraform-aws-modules/rds/aws?version=6.1.1"
}

inputs = {
  identifier = "raj-dev-rds"
  
  # Engine options
  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"
  
  allocated_storage     = 20
  max_allocated_storage = 100
  
  # Database name and credentials
  db_name  = "rajdevdb"
  username = "admin"
  port     = 3306
  
  # Use random password generation
  manage_master_user_password = true
  
  # Keep networking simple - no custom configurations
  create_db_subnet_group = false
  
  # Backup and maintenance
  backup_retention_period = 1
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"
  
  # Dev settings
  deletion_protection = false
  skip_final_snapshot = true
  
  # Tags
  tags = {
    Environment = "dev"
    Project     = "raj-tg-demo"
    ManagedBy   = "terragrunt"
    Owner       = "raj-dev-team"
  }
}
