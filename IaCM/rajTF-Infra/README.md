# Terraform Infrastructure Project

This project provisions AWS infrastructure for a dev environment with EC2 and S3 resources.

## Project Structure

```
.
├── dev/
│   ├── main.tf           # Main configuration
│   ├── variables.tf      # Variable definitions
│   ├── outputs.tf        # Output definitions
│   └── terraform.tfvars  # Variable values
├── modules/
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── .gitignore
```

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with credentials
- Appropriate AWS permissions for EC2 and S3

## Usage

1. Navigate to the dev environment:
   ```bash
   cd dev
   ```

2. Update `terraform.tfvars` with your specific values:
   - `ec2_ami_id`: Use an AMI ID valid for your region
   - `s3_bucket_name`: Must be globally unique

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the infrastructure:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

6. Destroy resources when done:
   ```bash
   terraform destroy
   ```

## Resources Created

- **EC2 Instance**: A single EC2 instance with configurable instance type
- **S3 Bucket**: An S3 bucket with versioning and encryption enabled

## Outputs

After applying, you'll see:
- EC2 instance ID and public IP
- S3 bucket name and ARN
