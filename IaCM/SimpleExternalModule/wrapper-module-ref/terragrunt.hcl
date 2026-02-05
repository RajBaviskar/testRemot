include "root" {
  path = find_in_parent_folders("root.hcl")
}

# This wrapper module CALLS an external module
# This pattern will create .terraform/modules/modules.json
terraform {
  source = "."
}

inputs = {
  bucket_name = "raj-wrapper-ref-12345"
}
