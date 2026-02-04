# Simple External Module Setup

This Terragrunt setup demonstrates the **difference between direct resources and external modules** in state files.

## Structure

```
SimpleExternalModule/
├── root.hcl                              # Root configuration with local backend
├── modules/
│   ├── s3-simple/                        # Local module with direct S3 resources
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── s3-wrapper/                       # Wrapper module that CALLS external module
│       ├── main.tf
│       └── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── s3-simple/                    # Direct resources (NO modules)
│   │   │   └── terragrunt.hcl
│   │   ├── s3-external/                  # External module AS root (no "module" in state)
│   │   │   └── terragrunt.hcl
│   │   └── s3-wrapper/                   # Wrapper calling external (HAS "module" in state)
│   │       └── terragrunt.hcl
│   └── prod/
│       ├── s3-simple/                    # Direct resources (NO modules)
│       │   └── terragrunt.hcl
│       ├── s3-external/                  # External module AS root (no "module" in state)
│       │   └── terragrunt.hcl
│       └── s3-wrapper/                   # Wrapper calling external (HAS "module" in state)
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

### 2. **External Module S3 Buckets** (External Module AS Root)
- **Source**: `terraform-aws-modules/s3-bucket/aws` (version 4.1.0)
- **Type**: External module from Terraform Registry used as root configuration
- **State File**: Resources appear WITHOUT `module.` prefix (root-level resources)
- **Environments**: `dev/s3-external` and `prod/s3-external`
- **Note**: External module IS the root, so no "module" key in state

### 3. **Wrapper Module S3 Buckets** (External Module CALLED by Wrapper)
- **Location**: `modules/s3-wrapper` (calls external module)
- **Type**: Local wrapper module that CALLS external module from Terraform Registry
- **State File**: Resources appear WITH `module.s3_bucket` prefix
- **Environments**: `dev/s3-wrapper` and `prod/s3-wrapper`
- **Note**: This is where you'll see external modules in state!

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

### 1. Simple Bucket State (Direct Resources)
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
**Notice**: No `"module"` key - direct resources

### 2. External Module Bucket State (External Module AS Root)
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
**Notice**: Still no `"module"` key - external module is the root configuration

### 3. Wrapper Module Bucket State (External Module CALLED)
```json
{
  "resources": [
    {
      "module": "module.s3_bucket",
      "type": "aws_s3_bucket",
      "name": "this"
    }
  ]
}
```
**Notice**: Has `"module": "module.s3_bucket"` - external module is called by wrapper!

## Key Differences

| Aspect | Simple Bucket | External (AS Root) | Wrapper (CALLS External) |
|--------|--------------|-------------------|-------------------------|
| **Module Type** | Local module | External from Registry | Local wrapper + External |
| **Source** | `modules/s3-simple` | `tfr:///terraform-aws-modules/s3-bucket/aws` | `modules/s3-wrapper` |
| **State File** | Direct resources | Direct resources (root) | Module-prefixed resources |
| **Resource Address** | `aws_s3_bucket.this` | `aws_s3_bucket.this[0]` | `module.s3_bucket.aws_s3_bucket.this[0]` |
| **"module" in State** | ❌ No | ❌ No | ✅ YES |
| **Use Case** | Custom code | Use module directly | Add logic around module |

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
