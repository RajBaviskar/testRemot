terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
    }
  }
  # required_version = "1.3.9"
}

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key = "pat.UKh5Yts7THSMAbccG3HrLA.6530352e1bc3b44b9f0cd0c4.M7iEe7prb252Os0u6kSw"
}

