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

resource "harness_platform_service" "ng" {
  identifier  = "csp_generalonboaringpipeline1"
  name        = "csp_generalonboaringpipeline1"
  description = "Creating service for testing csp-generalonboaringpipeline"
  org_id      = "default"
  project_id  = "rajTest"


  yaml = <<-EOT
                service:
                  name: csp_generalonboaringpipeline1
                  identifier: csp_generalonboaringpipeline1
                  serviceDefinition:
                    spec:
                      manifests:
                        - manifest:
                            identifier: deployment
                            type: K8sManifest
                            spec:
                              store:
                                type: Github
                                spec:
                                  connectorRef: account.ngcdharnessgithub
                                  gitFetchType: Branch
                                  paths:
                                    - csp-consentrequest/deployment/
                                  repoName: csp-consentrequest
                                  branch: master
                              skipResourceVersioning: false
                      configFiles:
                        - configFile:
                            identifier: configFile1
                            spec:
                              store:
                                type: Harness
                                spec:
                                  files:
                                    - <+org.description>
                      variables:
                        - name: var1
                          type: String
                          value: val1
                        - name: var2
                          type: String
                          value: val2
                    type: Kubernetes
                  gitOpsEnabled: false
              EOT
}
