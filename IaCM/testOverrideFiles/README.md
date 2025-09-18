# Terraform Variable Files (.tfvars)

This directory contains variable files that can be used instead of CLI `-var` flags for different environments.

## Available Variable Files

- `dev.tfvars` - Development environment
- `prod.tfvars` - Production environment  
- `staging.tfvars` - Staging environment
- `performance.tfvars` - Performance testing environment

## Usage Examples

### Using with Terragrunt

```bash
# Development environment
terragrunt plan -var-file="../../testOverrideFiles/dev.tfvars"
terragrunt apply -var-file="../../testOverrideFiles/dev.tfvars"

# Production environment
terragrunt plan -var-file="../../testOverrideFiles/prod.tfvars"
terragrunt apply -var-file="../../testOverrideFiles/prod.tfvars"

# Run-all with variable files
terragrunt run-all plan --terragrunt-working-dir environments/dev -var-file="../../testOverrideFiles/dev.tfvars"
terragrunt run-all apply --terragrunt-working-dir environments/prod -var-file="../../testOverrideFiles/prod.tfvars"
```

### Combining Variable Files with CLI Overrides

You can combine variable files with CLI variables (CLI takes precedence):

```bash
# Use staging.tfvars but override the owner
terragrunt plan -var-file="../../testOverrideFiles/staging.tfvars" -var="owner=custom-owner"

# Use prod.tfvars but override instance type
terragrunt apply -var-file="../../testOverrideFiles/prod.tfvars" -var="instance_type=t3.2xlarge"
```

### Variable File Contents

Each `.tfvars` file contains:
- `owner` - Resource owner
- `environment` - Environment name
- `project` - Project name
- `instance_type` - EC2 instance type
- `bucket_name` - S3 bucket name
- `aws_region` - AWS region

## Benefits of Variable Files

1. **Version Control** - Track variable changes over time
2. **Consistency** - Ensure same variables across team members
3. **Environment Management** - Easy switching between environments
4. **Documentation** - Clear visibility of environment configurations
5. **Automation** - Easy to use in CI/CD pipelines
