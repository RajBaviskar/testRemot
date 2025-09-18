#!/bin/bash

# Test script to demonstrate using .tfvars files instead of CLI variables
# Navigate to TGOverride directory first

echo "=== Testing Terragrunt with .tfvars files ==="
echo ""

# Change to TGOverride directory
cd ../TGOverride

echo "1. Plan dev environment using dev.tfvars:"
echo "   Command: terragrunt plan --terragrunt-working-dir environments/dev/s3 -var-file=\"../../testOverrideFiles/dev.tfvars\""
terragrunt plan --terragrunt-working-dir environments/dev/s3 -var-file="../../testOverrideFiles/dev.tfvars"

echo ""
echo "2. Plan prod environment using prod.tfvars:"
echo "   Command: terragrunt plan --terragrunt-working-dir environments/prod/ec2 -var-file=\"../../testOverrideFiles/prod.tfvars\""
terragrunt plan --terragrunt-working-dir environments/prod/ec2 -var-file="../../testOverrideFiles/prod.tfvars"

echo ""
echo "3. Run-all plan for dev environment using dev.tfvars:"
echo "   Command: terragrunt run-all plan --terragrunt-working-dir environments/dev -var-file=\"../../testOverrideFiles/dev.tfvars\""
terragrunt run-all plan --terragrunt-working-dir environments/dev -var-file="../../testOverrideFiles/dev.tfvars"

echo ""
echo "4. Run-all plan for prod environment using staging.tfvars (mixed scenario):"
echo "   Command: terragrunt run-all plan --terragrunt-working-dir environments/prod -var-file=\"../../testOverrideFiles/staging.tfvars\""
terragrunt run-all plan --terragrunt-working-dir environments/prod -var-file="../../testOverrideFiles/staging.tfvars"

echo ""
echo "5. Combine tfvars with CLI override:"
echo "   Command: terragrunt plan --terragrunt-working-dir environments/dev/ec2 -var-file=\"../../testOverrideFiles/performance.tfvars\" -var=\"owner=cli-override-owner\""
terragrunt plan --terragrunt-working-dir environments/dev/ec2 -var-file="../../testOverrideFiles/performance.tfvars" -var="owner=cli-override-owner"

echo ""
echo "=== Test completed ==="
echo ""
echo "Key benefits of .tfvars files:"
echo "- Version controlled variable configurations"
echo "- Easy environment switching"
echo "- Consistent team configurations"
echo "- Can still combine with CLI overrides"
echo "- Better for CI/CD automation"
