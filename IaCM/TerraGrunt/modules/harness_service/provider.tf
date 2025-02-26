terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
    }
  }
  # required_version = "1.3.9"
}

provider "harness" {
  endpoint         = var.endpoint
  account_id       = var.account_id
  platform_api_key = var.platform_api_key
}