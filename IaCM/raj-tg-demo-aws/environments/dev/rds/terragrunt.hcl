include "root" {
  path = find_in_parent_folders("root.hcl")
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
  
  # VPC and networking (using default VPC for simplicity)
  create_db_subnet_group = true
  subnet_ids             = [] # Will use default VPC subnets
  vpc_security_group_ids = [] # Will use default security group
  
  # Backup and maintenance
  backup_retention_period = 1
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"
  
  # Disable deletion protection for demo
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
