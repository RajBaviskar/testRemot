include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-aws-modules/rds/aws?version=6.1.1"
}

inputs = {
  identifier = "raj-prod-rds"
  
  # Engine options
  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.small"  # Slightly larger for prod
  
  allocated_storage     = 50
  max_allocated_storage = 200
  
  # Database name and credentials
  db_name  = "rajproddb"
  username = "admin"
  port     = 3306
  
  # Use random password generation
  manage_master_user_password = true
  
  # VPC and networking (using default VPC for simplicity)
  create_db_subnet_group = true
  subnet_ids             = [] # Will use default VPC subnets
  vpc_security_group_ids = [] # Will use default security group
  
  # Backup and maintenance (more robust for prod)
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "Sun:04:00-Sun:05:00"
  
  # Enable deletion protection for prod
  deletion_protection = true
  skip_final_snapshot = false
  final_snapshot_identifier = "raj-prod-rds-final-snapshot"
  
  # Performance insights for prod
  performance_insights_enabled = true
  performance_insights_retention_period = 7
  
  # Tags
  tags = {
    Environment = "prod"
    Project     = "raj-tg-demo"
    ManagedBy   = "terragrunt"
    Owner       = "raj-prod-team"
  }
}
