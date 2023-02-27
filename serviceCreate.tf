terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.14.0"
    }
  }
}

resource "harness_platform_service" "this" {
  identifier  = "DemoGitXV2Service"
  name        = "DemoGitXV2Service"
  org_id      = "default"
  project_id  = "rajTest"
  yaml        = <<-EOT
    service:
      name: DemoGitXV2Service
      identifier: DemoGitXV2Service
      tags: {}
      serviceDefinition:
        spec:
          manifests:
            - manifest:
                identifier: manifest1
                type: K8sManifest
                spec:
                  store:
                    type: Github
                    spec:
                      connectorRef: <+input>
                      gitFetchType: Branch
                      paths:
                        - files1
                      repoName: <+input>
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
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key = "pat.UKh5Yts7THSMAbccG3HrLA.631ad184015b135d5052742a.VsueShc2p2xD3abapFQG"
}
