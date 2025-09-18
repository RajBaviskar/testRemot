#!/bin/bash

# Test script to demonstrate CLI variable overrides with Terragrunt
# This script shows how to override variables using pure Terraform variables

echo "=== Testing CLI Variable Override with Terragrunt ==="
echo ""

# Navigate to the dev/s3 environment
cd environments/dev/s3

echo "1. Clean up any existing cache..."
rm -rf .terragrunt-cache

echo ""
echo "2. Initialize Terragrunt..."
terragrunt init

echo ""
echo "3. Plan with default values:"
echo "   Expected: owner=default-owner, environment=dev, project=simple-tg"
terragrunt plan

echo ""
echo "4. Plan with owner override:"
echo "   Command: terragrunt plan -var=\"owner=raj-custom-owner\""
terragrunt plan -var="owner=raj-custom-owner"

echo ""
echo "5. Plan with multiple variable overrides:"
echo "   Command: terragrunt plan -var=\"owner=custom-owner\" -var=\"environment=staging\" -var=\"project=my-project\""
terragrunt plan -var="owner=custom-owner" -var="environment=staging" -var="project=my-project"

echo ""
echo "6. Plan with all variables overridden:"
echo "   Command: terragrunt plan -var=\"owner=prod-owner\" -var=\"environment=production\" -var=\"project=enterprise-app\""
terragrunt plan -var="owner=prod-owner" -var="environment=production" -var="project=enterprise-app"

echo ""
echo "=== Test completed ==="
