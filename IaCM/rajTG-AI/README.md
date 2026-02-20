# Terragrunt AWS Infrastructure Project

This Terragrunt project provisions AWS infrastructure across three environments: QA, Staging, and Production.

## Infrastructure Components

Each environment includes:
- **1 S3 Bucket** with versioning and encryption enabled
- **2 EC2 Instances** (t2.small) running Amazon Linux 2

## Project Structure

```
rajTG-AI/
├── root.hcl                    # Root Terragrunt configuration with local backend
├── modules/
│   ├── s3/                     # S3 bucket module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/                    # EC2 instance module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── qa/
    │   ├── s3/terragrunt.hcl
    │   └── ec2/terragrunt.hcl
    ├── staging/
    │   ├── s3/terragrunt.hcl
    │   └── ec2/terragrunt.hcl
    └── prod/
        ├── s3/terragrunt.hcl
        └── ec2/terragrunt.hcl
```

## State Management

This project uses a **local backend** for state management. State files are stored in:
- `states/environments/{environment}/{module}/terraform.tfstate`

Examples:
- QA S3: `states/environments/qa/s3/terraform.tfstate`
- QA EC2: `states/environments/qa/ec2/terraform.tfstate`

## Usage

### Initialize All Environments

```bash
cd /Users/rajendrabaviskar/testRemot/IACM/rajTG-AI
terragrunt run-all init
```

### Plan All Environments

```bash
terragrunt run-all plan
```

### Apply All Environments

```bash
terragrunt run-all apply
```

### Work with Specific Environment

**QA Environment:**
```bash
# Initialize QA
terragrunt run-all init --terragrunt-working-dir environments/qa

# Plan QA
terragrunt run-all plan --terragrunt-working-dir environments/qa

# Apply QA
terragrunt run-all apply --terragrunt-working-dir environments/qa
```

**Staging Environment:**
```bash
terragrunt run-all init --terragrunt-working-dir environments/staging
terragrunt run-all plan --terragrunt-working-dir environments/staging
terragrunt run-all apply --terragrunt-working-dir environments/staging
```

**Production Environment:**
```bash
terragrunt run-all init --terragrunt-working-dir environments/prod
terragrunt run-all plan --terragrunt-working-dir environments/prod
terragrunt run-all apply --terragrunt-working-dir environments/prod
```

### Work with Specific Module

```bash
# QA S3 bucket only
cd environments/qa/s3
terragrunt init
terragrunt plan
terragrunt apply

# QA EC2 instances only
cd environments/qa/ec2
terragrunt init
terragrunt plan
terragrunt apply
```

### Destroy Resources

```bash
# Destroy all environments
terragrunt run-all destroy

# Destroy specific environment
terragrunt run-all destroy --terragrunt-working-dir environments/qa

# Destroy specific module
cd environments/qa/s3
terragrunt destroy
```

## Environment Details

### QA Environment
- S3 Bucket: `raj-qa-bucket-ai-demo`
- EC2 Instances: 2x t2.small (named: qa-instance-1, qa-instance-2)
- Owner: qa-team

### Staging Environment
- S3 Bucket: `raj-staging-bucket-ai-demo`
- EC2 Instances: 2x t2.small (named: staging-instance-1, staging-instance-2)
- Owner: staging-team

### Production Environment
- S3 Bucket: `raj-prod-bucket-ai-demo`
- EC2 Instances: 2x t2.small (named: prod-instance-1, prod-instance-2)
- Owner: prod-team

## Prerequisites

- Terragrunt installed
- Terraform installed
- AWS CLI configured with appropriate credentials
- AWS permissions to create S3 buckets and EC2 instances

## Notes

- All S3 buckets have versioning enabled
- All S3 buckets use AES256 server-side encryption
- EC2 instances use the latest Amazon Linux 2 AMI
- Instance type is set to t2.small for all environments
