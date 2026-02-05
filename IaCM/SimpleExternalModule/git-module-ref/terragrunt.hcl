include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Reference to module from Git repository with ref (similar to basicModuleRef pattern)
terraform {
  source = "git::https://github.com/RajBaviskar/testRemot.git//IaCM/SimpleExternalModule/modules/s3-simple?ref=main"
}

inputs = {
  bucket_name = "raj-git-ref-12345"
  environment = "dev"
}
