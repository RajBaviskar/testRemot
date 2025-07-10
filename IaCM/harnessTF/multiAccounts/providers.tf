provider "harness" {
  alias             = "qa"
  endpoint          = "https://qa.harness.io/gateway"
  account_id        = "25NKDX79QPC-YTyninmxRQ"
  platform_api_key  = ""
}

provider "harness" {
  alias             = "prod"
  endpoint          = "https://app.harness.io/gateway"
  account_id        = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key  = ""
}
