terraform {
  source = "../../modules/harness_service"
}

inputs = {
  harness_org_id     = "default"
  harness_project_id = "rajTest"
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key = ""
}
