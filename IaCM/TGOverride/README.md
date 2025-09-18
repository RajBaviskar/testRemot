# Simple Terragrunt Setup with CLI Variable Override

This is a simple Terragrunt setup that demonstrates how to override variables via CLI during plan or apply operations.

## Directory Structure

```
TGOverride/
├── terragrunt.hcl              # Root configuration
├── modules/
│   ├── s3/
│   │   └── main.tf             # S3 bucket module
│   └── ec2/
│       └── main.tf             # EC2 instance module
└── environments/
    ├── dev/
    │   ├── s3/
    │   │   └── terragrunt.hcl  # Dev S3 config
    │   └── ec2/
    │       └── terragrunt.hcl  # Dev EC2 config
    └── prod/
        ├── s3/
        │   └── terragrunt.hcl  # Prod S3 config
        └── ec2/
            └── terragrunt.hcl  # Prod EC2 config
```

## Key Features

1. **Variable Override Support**: All variables can be overridden via CLI
2. **Environment Separation**: Dev and Prod environments with different defaults
3. **Common Tagging**: Consistent tagging across all resources
4. **Local State**: Uses local state files for simplicity

## Available Variables for Override

- `owner` - Owner of the resources (default: "default-owner")
- `environment` - Environment name (default: "dev")
- `project` - Project name (default: "simple-tg")
- `aws_region` - AWS region (default: "us-east-1")

## Usage Examples

### 1. Basic Commands

```bash
# Initialize
cd environments/dev/s3
terragrunt init

# Plan with default values
terragrunt plan

# Apply with default values
terragrunt apply
```

### 2. CLI Variable Override Examples

```bash
# Override owner via CLI
terragrunt plan -var="owner=raj-custom-owner"
terragrunt apply -var="owner=raj-custom-owner"

# Override multiple variables
terragrunt plan -var="owner=custom-owner" -var="environment=staging" -var="project=my-project"

# Override environment and project
terragrunt apply -var="environment=test" -var="project=demo-app"
```

### 3. Using terraform.tfvars file

```bash
# Create a terraform.tfvars file
echo 'owner = "file-owner"' > terraform.tfvars
echo 'environment = "staging"' >> terraform.tfvars
echo 'project = "my-app"' >> terraform.tfvars

# Run terragrunt (will use tfvars file)
terragrunt plan
```

### 4. Run All Environments

```bash
# From root directory, run all modules
terragrunt run-all plan
terragrunt run-all apply

# With variable overrides for all modules
terragrunt run-all plan -var="owner=global-owner"
terragrunt run-all apply -var="owner=global-owner"
```

## Testing Variable Overrides

1. **Check Default Values**:
   ```bash
   cd environments/dev/s3
   terragrunt plan
   # Should show: Owner = "default-owner", Environment = "dev", Project = "simple-tg"
   ```

2. **Test CLI Override**:
   ```bash
   terragrunt plan -var="owner=test-owner"
   # Should show: Owner = "test-owner", Environment = "dev", Project = "simple-tg"
   ```

3. **Test Multiple Overrides**:
   ```bash
   terragrunt plan -var="owner=custom-owner" -var="environment=staging"
   # Should show: Owner = "custom-owner", Environment = "staging", Project = "simple-tg"
   ```

## State Files

State files are stored locally in the `states/` directory:
- Dev S3: `states/environments/dev/s3/terraform.tfstate`
- Dev EC2: `states/environments/dev/ec2/terraform.tfstate`
- Prod S3: `states/environments/prod/s3/terraform.tfstate`
- Prod EC2: `states/environments/prod/ec2/terraform.tfstate`

## Notes

- The setup uses local state backend for simplicity
- All resources are tagged with Owner, Environment, Project, and ManagedBy
- Variables defined in the root terragrunt.hcl are automatically available in all modules
- CLI overrides take precedence over default values and environment variables
