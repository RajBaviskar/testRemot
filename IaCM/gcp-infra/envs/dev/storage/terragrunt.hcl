include "root" {
  path = find_in_parent_folders()
}

locals {
  project = "iac-play"
  region  = "us-central1"
}

terraform {
  source = "../../../modules/storage"
}

inputs = {
  project = local.project
  region  = local.region
}
