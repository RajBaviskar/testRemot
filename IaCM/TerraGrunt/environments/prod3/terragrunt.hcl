terraform {
  source = "../../modules/harness_service"
}

inputs = {
  harness_org_id     = "default"
  harness_project_id = "rajTest"
  endpoint         = "https://app3.harness.io/gateway"
  account_id       = "kmpySmUISimoRrJL6NL73w"
  platform_api_key = ""
}
