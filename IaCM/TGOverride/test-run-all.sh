#!/bin/bash

# Test script to demonstrate run-all CLI variable overrides with Terragrunt
# This script shows how to override variables using run-all commands

echo "=== Testing run-all CLI Variable Override with Terragrunt ==="
echo ""

# Clean up any existing cache from all environments
echo "1. Clean up all existing caches..."
find . -name ".terragrunt-cache" -type d -exec rm -rf {} + 2>/dev/null || true

echo ""
echo "2. Initialize all modules with run-all..."
terragrunt run-all init

echo ""
echo "3. Plan all modules with default values:"
echo "   Expected: owner=default-owner, environment=dev, project=simple-tg"
terragrunt run-all plan

echo ""
echo "4. Plan all modules with owner override:"
echo "   Command: terragrunt run-all plan -var=\"owner=raj-global-owner\""
terragrunt run-all plan -var="owner=raj-global-owner"

echo ""
echo "5. Plan all modules with multiple variable overrides:"
echo "   Command: terragrunt run-all plan -var=\"owner=global-owner\" -var=\"environment=staging\" -var=\"project=enterprise-app\""
terragrunt run-all plan -var="owner=global-owner" -var="environment=staging" -var="project=enterprise-app"

echo ""
echo "6. Plan all modules with instance_type override (now works from environment level!):"
echo "   Command: terragrunt run-all plan --terragrunt-working-dir environments/dev -var=\"owner=perf-owner\" -var=\"instance_type=t3.large\""
terragrunt run-all plan --terragrunt-working-dir environments/dev -var="owner=perf-owner" -var="instance_type=t3.large"

echo ""
echo "7. Plan all environments with instance_type override:"
echo "   Command: terragrunt run-all plan -var=\"owner=global-owner\" -var=\"instance_type=t3.medium\""
terragrunt run-all plan -var="owner=global-owner" -var="instance_type=t3.medium"

echo ""
echo "8. Plan prod environment with multiple overrides:"
echo "   Command: terragrunt run-all plan --terragrunt-working-dir environments/prod -var=\"owner=prod-owner\" -var=\"environment=production\" -var=\"instance_type=t3.xlarge\""
terragrunt run-all plan --terragrunt-working-dir environments/prod -var="owner=prod-owner" -var="environment=production" -var="instance_type=t3.xlarge"

echo ""
echo "=== Test completed ==="
echo ""
echo "Summary of improved run-all usage patterns:"
echo "- terragrunt run-all init: Initialize all modules"
echo "- terragrunt run-all plan: Plan all modules"
echo "- terragrunt run-all plan -var=\"key=value\": Override ANY variable for all modules"
echo "- terragrunt run-all plan --terragrunt-working-dir path: Target specific directory"
echo ""
echo "Key improvement: All modules now include all common variables with defaults"
echo "- instance_type works on S3 (ignored) and EC2 (used)"
echo "- bucket_name works on EC2 (ignored) and S3 (used)"
echo "- This allows run-all to work from any level without errors"
echo ""
echo "Benefits:"
echo "- Can run from environment folders: terragrunt run-all plan --terragrunt-working-dir environments/dev -var=\"instance_type=t3.large\""
echo "- No need to target specific modules for common overrides"
echo "- Terragrunt gracefully handles unused variables"
