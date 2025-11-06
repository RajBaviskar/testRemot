include "root" {
  path = find_in_parent_folders()
}

locals {
  project = "iac-play"
  region  = "us-central1"
}

terraform {
  source = "../../../modules/compute"
}

# Optional: Add dependency on storage if compute needs it
# dependency "storage" {
#   config_path = "../storage"
# }

inputs = {
  project = local.project
  region  = local.region
}
