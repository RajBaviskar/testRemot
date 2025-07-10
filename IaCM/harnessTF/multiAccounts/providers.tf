provider "harness" {
  alias             = "qa"
  endpoint          = "https://qa.harness.io/gateway"
  account_id        = "25NKDX79QPC-YTyninmxRQ"
  platform_api_key  = "pat.25NKDX79QPC-YTyninmxRQ.68494acbdd643d4711432214.23T84eQQfqhcRYnoPPAY"
}

provider "harness" {
  alias             = "prod"
  endpoint          = "https://app.harness.io/gateway"
  account_id        = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key  = "pat.UKh5Yts7THSMAbccG3HrLA.6465e07e2563857ae4307892.DxqTUAQsVDw1u7laE6tz"
}
