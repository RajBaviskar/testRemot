# Simple External Module Setup

This Terragrunt setup demonstrates the **difference between direct resources and external modules** in state files.

## Structure

```
SimpleExternalModule/
├── root.hcl                              # Root configuration with local backend
├── modules/
│   └── s3-simple/                        # Local module with direct S3 resources
│       ├── main.tf
│       └── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── s3-simple/                    # Dev: Simple bucket (NO external module)
│   │   │   └── terragrunt.hcl
│   │   └── s3-external/                  # Dev: External module bucket
│   │       └── terragrunt.hcl
│   └── prod/
│       ├── s3-simple/                    # Prod: Simple bucket (NO external module)
│       │   └── terragrunt.hcl
│       └── s3-external/                  # Prod: External module bucket
│           └── terragrunt.hcl
├── states/                               # Local state files (auto-generated)
└── README.md
```

## What's Included

### 1. **Simple S3 Buckets** (Direct Resources)
- **Location**: `modules/s3-simple`
- **Type**: Local module with direct `aws_s3_bucket` resources
- **State File**: Resources appear as `aws_s3_bucket.this` (NO module prefix)
- **Environments**: `dev/s3-simple` and `prod/s3-simple`

### 2. **External Module S3 Buckets**
- **Source**: `terraform-aws-modules/s3-bucket/aws` (version 4.1.0)
- **Type**: External module from Terraform Registry
- **State File**: Resources appear with `module.` prefix (e.g., `module.this`)
- **Environments**: `dev/s3-external` and `prod/s3-external`

## How to Use

### Run All Environments
```bash
cd IaCM/SimpleExternalModule
terragrunt run-all init
terragrunt run-all plan
terragrunt run-all apply
```

### Run Specific Environment

#### Dev Simple Bucket (NO external module)
```bash
cd environments/dev/s3-simple
terragrunt init
terragrunt plan
terragrunt apply
```

#### Dev External Module Bucket
```bash
cd environments/dev/s3-external
terragrunt init
terragrunt plan
terragrunt apply
```

### View State Files

#### Simple bucket state (direct resources)
```bash
cat states/environments/dev/s3-simple/terraform.tfstate
```

#### External module bucket state
```bash
cat states/environments/dev/s3-external/terraform.tfstate
```

## State File Comparison

### Simple Bucket State (NO External Module)
```json
{
  "resources": [
    {
      "type": "aws_s3_bucket",
      "name": "this",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]"
    }
  ]
}
```
**Notice**: No `"module"` key - resources are managed directly

### External Module Bucket State
```json
{
  "resources": [
    {
      "module": "module.this",
      "type": "aws_s3_bucket",
      "name": "this"
    }
  ]
}
```
**Notice**: Has `"module": "module.this"` - resources are managed through external module

## Key Differences

| Aspect | Simple Bucket | External Module |
|--------|--------------|----------------|
| **Module Type** | Local module | Terraform Registry |
| **Source** | `../../../modules/s3-simple` | `tfr:///terraform-aws-modules/s3-bucket/aws` |
| **State File** | Direct resources | Module-prefixed resources |
| **Resource Address** | `aws_s3_bucket.this` | `module.this.aws_s3_bucket.this[0]` |
| **Customization** | Full control | Limited to module inputs |

## Clean Up

### Destroy all environments
```bash
terragrunt run-all destroy
```

### Destroy specific environment
```bash
cd environments/dev/s3-simple
terragrunt destroy
```

## Configuration Examples

### Local Module Reference
```hcl
terraform {
  source = "../../../modules/s3-simple"
}
```

### External Module Reference
```hcl
terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0"
}
```
