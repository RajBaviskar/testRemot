terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.14.10"
    }
  }
}

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key = "pat.UKh5Yts7THSMAbccG3HrLA.631ad184015b135d5052742a.VsueShc2p2xD3abapFQG"
}

resource "harness_platform_environment" "ng_dev" {
  identifier = "csp_generalonboaringpipeline1_dev"
  name       = "csp_generalonboaringpipeline1_dev"
  org_id     = "default"
  project_id = "rajTest"
  type       = "PreProduction"
  yaml = <<-EOT
  environment:
         name: csp_generalonboaringpipeline1_dev
         identifier: csp_generalonboaringpipeline1_dev
         orgIdentifier: default
         projectIdentifier: rajTest
         type: PreProduction
         variables:
           - name: envVar1
             type: String
             value: v1
             description: ""
           - name: envVar2
             type: String
             value: v2
             description: ""
         overrides:
           configFiles:
             - configFile:
                 identifier: configFile1
                 spec:
                   store:
                     type: Harness
                     spec:
                       files:
                         - account:/Add-ons/svcOverrideTest
      EOT
}
