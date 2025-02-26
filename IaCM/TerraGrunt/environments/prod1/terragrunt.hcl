terraform {
  source = "../../modules/harness_service"
}

inputs = {
  harness_org_id     = "default"
  harness_project_id = "rajTest"
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "rF8pCuTYSzm8VSh9zuJtXQ"
  platform_api_key = ""
}
