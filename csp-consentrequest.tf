terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.14.10"
    }
  }
}

resource "harness_platform_service" "ng" {
  identifier  = "csp_generalonboaringpipeline1"
  name        = "csp_generalonboaringpipeline1"
  description = "Creating service for testing csp-generalonboaringpipeline"
  org_id      = "default"
  project_id  = "Generalonboaringpipeline"


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
provider "harness" {
  endpoint         = "https://harness-ng.paloaltonetworks.com"
  #endpoint         ="https://app.harness.io/gateway"
}
