# Module Reference Examples

Minimal Terragrunt setup demonstrating two module reference patterns:
1. **Git module reference** with version (like basicModuleRef pattern)
2. **External module reference** from Terraform Registry with version

## Structure

```
SimpleExternalModule/
├── root.hcl                              # Root configuration with local backend
├── modules/
│   └── s3-simple/                        # Simple S3 module for Git reference
│       ├── main.tf
│       └── outputs.tf
├── git-module-ref/                       # References module from Git (like basicModuleRef)
│   └── terragrunt.hcl
├── external-module-ref/                  # References external module from Terraform Registry
│   └── terragrunt.hcl
├── states/                               # Local state files (auto-generated)
└── README.md
```

## Module Reference Patterns

### 1. Git Module Reference (Similar to basicModuleRef)
- **File**: `git-module-ref/terragrunt.hcl`
- **Source**: Git repository with `?ref=main` for version control
- **Pattern**: `git::https://github.com/USER/REPO.git//path/to/module?ref=main`
- **Use Case**: Reference modules from Git with branch/tag pinning

### 2. External Module Reference (Terraform Registry)
- **File**: `external-module-ref/terragrunt.hcl`
- **Source**: Terraform Registry with `?version=4.1.0` for semantic versioning
- **Pattern**: `tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0`
- **Use Case**: Reference public modules from Terraform Registry with version pinning

## Usage

### Git Module Reference
```bash
cd git-module-ref
terragrunt init
terragrunt plan
terragrunt apply

# View state file
cat ../states/git-module-ref/terraform.tfstate
```

### External Module Reference
```bash
cd external-module-ref
terragrunt init
terragrunt plan
terragrunt apply

# View state file
cat ../states/external-module-ref/terraform.tfstate
```

### Run Both
```bash
cd IaCM/SimpleExternalModule
terragrunt run-all init
terragrunt run-all plan
terragrunt run-all apply
```

## State File Output

Both patterns will show resources WITHOUT `"module"` prefix because Terragrunt makes the module source the ROOT configuration:

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

**Note**: No `"module"` key appears in state when using Terragrunt's `terraform.source` pattern, as the module becomes the root configuration.

## Key Differences

| Aspect | Git Module Reference | External Module Reference |
|--------|---------------------|---------------------------|
| **Source Type** | Git repository | Terraform Registry |
| **Source Pattern** | `git::https://...?ref=main` | `tfr:///module-path?version=4.1.0` |
| **Version Syntax** | `?ref=<branch/tag>` | `?version=<semver>` |
| **Version Example** | `?ref=v1.0.0` | `?version=4.1.0` |
| **State File** | Direct resources (root) | Direct resources (root) |
| **"module" in State** | ❌ No | ❌ No |
| **Use Case** | Version control via Git | Use public registry modules |

## Clean Up

```bash
# Destroy both
terragrunt run-all destroy

# Or individually
cd git-module-ref && terragrunt destroy
cd external-module-ref && terragrunt destroy
```

## Configuration Examples

### Git Module Reference (Similar to basicModuleRef)
**File**: `git-module-ref/terragrunt.hcl`

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/RajBaviskar/testRemot.git//IaCM/SimpleExternalModule/modules/s3-simple?ref=main"
}

inputs = {
  bucket_name = "raj-git-ref-12345"
  environment = "dev"
}
```

### External Module Reference with Version
**File**: `external-module-ref/terragrunt.hcl`

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-aws-modules/s3-bucket/aws?version=4.1.0"
}

inputs = {
  bucket = "raj-external-ref-12345"
  versioning = { enabled = true }
  # ... additional configuration
}
```

## Version Pinning

| Source Type | Version Syntax | Example |
|-------------|----------------|----------|
| **Git** | `?ref=<branch/tag>` | `?ref=main` or `?ref=v1.0.0` |
| **Terraform Registry** | `?version=<semver>` | `?version=4.1.0` or `?version=~> 4.1` |
| **Local** | No version needed | `../../modules/s3-simple` |
