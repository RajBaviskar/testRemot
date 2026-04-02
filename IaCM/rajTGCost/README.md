# rajTGCost - Terragrunt EC2 Project

This project provisions a single EC2 instance in the dev environment using Terragrunt.

## Project Structure

```
rajTGCost/
├── terragrunt.hcl                    # Root Terragrunt configuration
├── environments/
│   └── dev/
│       ├── terragrunt.hcl            # Dev environment configuration
│       └── ec2/
│           └── terragrunt.hcl        # Dev EC2 configuration
└── modules/
    └── ec2/
        ├── main.tf                    # EC2 Terraform module
        └── variables.tf               # Variables definition
```

## Prerequisites

- Terraform (>= 1.0)
- Terragrunt
- AWS CLI configured with credentials
- AWS credentials with EC2 permissions
- S3 bucket `rajtgcost` must exist in us-east-1

## Commands - Run from ANY Level!

### From Root Directory (All Modules)
```bash
cd /Users/rajendrabaviskar/testRemot/IaCM/rajTGCost

# Initialize all modules
terragrunt run-all init

# Plan all modules
terragrunt run-all plan

# Apply all modules
terragrunt run-all apply

# Destroy all modules
terragrunt run-all destroy
```

### From Environment Level (Dev Environment)
```bash
cd /Users/rajendrabaviskar/testRemot/IaCM/rajTGCost/environments/dev

# Initialize all modules in dev
terragrunt run-all init

# Plan all modules in dev
terragrunt run-all plan

# Apply all modules in dev
terragrunt run-all apply

# Destroy all modules in dev
terragrunt run-all destroy
```

### From Module Level (Single EC2 Module)
```bash
cd /Users/rajendrabaviskar/testRemot/IaCM/rajTGCost/environments/dev/ec2

# Initialize single module
terragrunt init

# Plan single module
terragrunt plan

# Apply single module
terragrunt apply

# Destroy single module
terragrunt destroy
```

## Quick Reference

### Single Module Commands
| Command | Description |
|---------|-------------|
| `terragrunt init` | Initialize Terragrunt and download providers |
| `terragrunt plan` | Show execution plan |
| `terragrunt apply` | Create/update infrastructure |
| `terragrunt destroy` | Destroy infrastructure |
| `terragrunt output` | Show outputs |
| `terragrunt validate` | Validate configuration |

### Run-All Commands (from root or environment level)
| Command | Description |
|---------|-------------|
| `terragrunt run-all init` | Initialize all modules |
| `terragrunt run-all plan` | Plan all modules |
| `terragrunt run-all apply` | Apply all modules |
| `terragrunt run-all destroy` | Destroy all modules |
| `terragrunt run-all output` | Show all outputs |
| `terragrunt run-all validate` | Validate all modules |

## What Gets Provisioned

- 1 EC2 instance (t3.medium)
- Amazon Linux 2 AMI (latest)
- Region: us-east-1
- Tags: Environment=dev, Project=rajTGCost, ManagedBy=Terragrunt

**Cost**: ~$0.0416/hour (~$30/month for t3.medium)

## State Management

This project uses **S3 backend** for state management. The state file will be stored in:
```
S3 Bucket: rajtgcost
Key: environments/dev/ec2/terraform.tfstate
Region: us-east-1
Encryption: Enabled
```

**Note:** Make sure the S3 bucket `rajtgcost` exists in `us-east-1` region before running terragrunt commands.

## Notes

- The project is self-sufficient with all defaults configured
- Uses S3 bucket `rajtgcost` for remote state
- Instance type: **t3.medium** (~$30/month) - This will incur AWS charges!
- Automatically selects the latest Amazon Linux 2 AMI
- **Remember to destroy resources when done to avoid charges!**
