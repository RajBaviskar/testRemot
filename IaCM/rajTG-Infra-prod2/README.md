# Terragrunt Infrastructure - prod2

Simple Terragrunt project with 2 environments (dev and prod) deploying EC2 and S3 resources.

## Structure

```
rajTG-Infra-prod2/
├── root.hcl                    # Root configuration with S3 backend
├── modules/
│   ├── ec2/                    # EC2 instance module
│   └── s3/                     # S3 bucket module
├── dev/
│   ├── ec2/terragrunt.hcl     # Dev EC2 config (t3.micro)
│   └── s3/terragrunt.hcl      # Dev S3 config
└── prod/
    ├── ec2/terragrunt.hcl     # Prod EC2 config (t3.small)
    └── s3/terragrunt.hcl      # Prod S3 config
```

## Backend Configuration

- **S3 Bucket**: `raj-tg-infra-prod2-state`
- **DynamoDB Table**: `tg-infra-prod2-lock`
- **Region**: `us-east-1`

## Resources

### Dev Environment
- **EC2**: t3.micro instance named `dev-ec2-server`
- **S3**: Bucket named `raj-dev-app-bucket-prod2` with versioning enabled

### Prod Environment
- **EC2**: t3.small instance named `prod-ec2-server`
- **S3**: Bucket named `raj-prod-app-bucket-prod2` with versioning enabled

## Usage

### Initialize all modules
```bash
terragrunt run-all init
```

### Plan all environments
```bash
terragrunt run-all plan
```

### Apply all environments
```bash
terragrunt run-all apply
```

### Work with specific environment
```bash
cd dev/ec2
terragrunt plan
terragrunt apply

cd ../s3
terragrunt plan
terragrunt apply
```

### Destroy all resources
```bash
terragrunt run-all destroy
```

## Notes

- All values are hardcoded in terragrunt.hcl files
- No dependencies between modules
- Each module maintains its own state file in S3
