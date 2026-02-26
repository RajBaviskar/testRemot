# Terragrunt Provider Upgrade Demo - Real-World CI/CD Scenario

## Scenario: Provider Upgrade Broke Working Infrastructure 🔥

### What Happened

**Last Week:**
- ✅ Deployment worked perfectly with AWS provider `~> 4.0`
- ✅ CI/CD pipeline green
- ✅ Infrastructure stable

**This Week:**
- 🔄 CI/CD automatically pulled latest AWS provider `~> 5.0`
- ❌ `terraform plan` now fails with validation error
- 🚨 Deployment blocked

### The Problem

**Provider breaking change**: AWS provider 5.x+ enforces stricter type validation - strings are no longer accepted for boolean attributes.

**Our code** (worked in 4.x):
```hcl
resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  
  ebs_optimized = "true"  # ⚠️ String instead of boolean - fails in 5.x+
}
```

**Error Message:**
```
Error: Incorrect attribute value type

  on main.tf line 24, in resource "aws_instance" "this":
  24:   ebs_optimized = "true"

Inappropriate value for attribute "ebs_optimized": bool required.
```

### LLM Fix Options

**Option 1: Pin to Working Version** (Quick fix)
```hcl
# versions.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Pin to last working version
    }
  }
}
```

**Option 2: Update Code Syntax** (Recommended)
```hcl
# Remove the conflicting arguments entirely
resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  # Removed ipv6_address_count and ipv6_addresses - not needed
}
```

## Project Structure
```
rajTG-AI-IAMRole/
├── root.hcl                              # Root Terragrunt config
├── modules/
│   └── ec2-simple/                       # EC2 module with provider 5.x conflict
│       ├── main.tf                       # Contains IPv6 conflict
│       ├── versions.tf                   # Specifies provider ~> 5.0
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    └── qa/ec2/                           # QA environment
        └── terragrunt.hcl
```

## Quick Start

### Try to Deploy (Will Fail)
```bash
cd /Users/rajendrabaviskar/testRemot/IaCM/rajTG-AI-IAMRole

# Initialize
terragrunt init --terragrunt-working-dir environments/qa/ec2

# Try to plan - will fail at validation
terragrunt plan --terragrunt-working-dir environments/qa/ec2
```

**Expected Error:**
```
Error: Conflicting configuration arguments

  with aws_instance.this[0],
  on main.tf line 21, in resource "aws_instance" "this":
  21:   ipv6_address_count = 0

"ipv6_address_count": conflicts with ipv6_addresses
```

### How to Fix (LLM Suggestions)

**Option 1: Pin Provider Version** (Quick rollback)
```hcl
# modules/ec2-simple/versions.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Downgrade to working version
    }
  }
}
```

**Option 2: Update Code** (Recommended)
```hcl
# modules/ec2-simple/main.tf
# Fix type error: change string to boolean
resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  
  ebs_optimized = true  # Changed from "true" (string) to true (boolean)
  
  tags = {
    Name        = "${var.environment}-instance-${count.index + 1}"
    Environment = var.environment
    Owner       = var.owner
  }
}
```

## Clean Up
```bash
terragrunt destroy --terragrunt-working-dir environments/qa/ec2
```

## Key Takeaways

1. **Provider Upgrades Can Break Working Code**: Always pin provider versions in production
2. **Validation Happens Before Apply**: Even destroy operations fail if config is invalid
3. **LLM Can Diagnose Provider Issues**: Clear error messages point to the solution
4. **Two Fix Strategies**: Rollback to old version OR update code syntax
