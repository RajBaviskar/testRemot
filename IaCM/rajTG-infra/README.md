# Terragrunt Independent Modules Demo

This project demonstrates Terragrunt with independent modules that can be deployed in parallel:
**S3 | IAM Role | EC2** (no dependencies)

## Project Structure

```
rajTG-seq/
├── dev/
│   ├── terragrunt.hcl          # Parent config with S3 backend
│   ├── s3/
│   │   └── terragrunt.hcl      # S3 bucket (no dependencies)
│   ├── iamrole/
│   │   └── terragrunt.hcl      # IAM role (no dependencies)
│   └── ec2/
│       └── terragrunt.hcl      # EC2 instance (no dependencies)
└── modules/
    ├── s3/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── iamrole/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Independent Modules

1. **S3 Bucket** - Creates bucket `dev-raj-seq-artifacts`
2. **IAM Role** - Creates `dev-raj-ec2-role` with hardcoded S3 bucket name for access policy
3. **EC2 Instance** - Creates EC2 instance with hardcoded IAM role name for instance profile

**Note:** Modules are independent and can be applied in any order or in parallel.

## Prerequisites

- Terragrunt installed
- AWS credentials configured
- S3 bucket `raj-tg-test-seq` exists (for state storage)
- DynamoDB table `tg-lock-table` exists (for state locking)

## Usage

### Initialize all modules
```bash
cd dev
terragrunt run-all init
```

### Plan all modules (respects dependencies)
```bash
terragrunt run-all plan
```

### Apply all modules (parallel execution)
```bash
terragrunt run-all apply
```

### Apply specific module
```bash
# Apply just S3
terragrunt apply --terragrunt-working-dir dev/s3

# Apply just IAM role (no dependencies)
terragrunt apply --terragrunt-working-dir dev/iamrole

# Apply just EC2 (no dependencies)
terragrunt apply --terragrunt-working-dir dev/ec2
```

### Destroy all modules (reverse order)
```bash
terragrunt run-all destroy
```

## Module Configuration

### IAM Role (independent):
```hcl
inputs = {
  role_name = "dev-raj-ec2-role"
  s3_bucket = "dev-raj-seq-artifacts"  # Hardcoded bucket name
}
```

### EC2 (independent):
```hcl
inputs = {
  instance_type  = "t3.micro"
  iam_role_name  = "dev-raj-ec2-role"  # Hardcoded role name
}
```

## Resources Created

- **S3 Bucket**: `dev-raj-seq-artifacts`
- **IAM Role**: `dev-raj-ec2-role`
- **IAM Policy**: `dev-raj-ec2-role-s3-access` (grants S3 access)
- **EC2 Instance**: `dev-raj-ec2` (t3.micro with IAM instance profile)

## Notes

- All modules are independent and can be deployed in parallel
- State files are stored in S3: `raj-tg-test-seq/{module-path}/terraform.tfstate`
- DynamoDB is used for state locking to prevent concurrent modifications
- IAM role and EC2 use hardcoded values instead of dependencies for simplicity
