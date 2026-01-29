# Raj Terragrunt Demo - Local Backend

Simple Terragrunt setup with local backend for testing and development.

## Structure

```
rajtgdemoLocalBE/
├── root.hcl                    # Root configuration with local backend
├── modules/
│   ├── ec2/
│   │   └── main.tf            # EC2 instance module
│   └── s3/
│       └── main.tf            # S3 bucket module
├── environments/
│   └── dev/
│       ├── ec2/
│       │   └── terragrunt.hcl # Dev EC2 configuration
│       └── s3/
│           └── terragrunt.hcl # Dev S3 configuration
└── states/                    # Local state files (auto-created)
```

## Features

- **Local Backend**: No S3 bucket required, state stored locally
- **Simple Setup**: Just EC2 and S3 modules
- **No External Dependencies**: No environment variables needed

## Usage

### Initialize all modules
```bash
cd /Users/rajendrabaviskar/testRemot/IaCM/rajtgdemoLocalBE
terragrunt run-all init
```

### Plan all modules
```bash
terragrunt run-all plan
```

### Apply all modules
```bash
terragrunt run-all apply
```

### Work with specific modules
```bash
# EC2 only
terragrunt plan --terragrunt-working-dir environments/dev/ec2
terragrunt apply --terragrunt-working-dir environments/dev/ec2

# S3 only
terragrunt plan --terragrunt-working-dir environments/dev/s3
terragrunt apply --terragrunt-working-dir environments/dev/s3
```

### Clean up
```bash
terragrunt run-all destroy
```

## State Files

State files are stored locally in the `states/` directory:
- EC2: `states/environments/dev/ec2/terraform.tfstate`
- S3: `states/environments/dev/s3/terraform.tfstate`

## Resources Created

- **EC2**: t3.micro Amazon Linux instance in default VPC
- **S3**: Bucket with versioning and encryption enabled
