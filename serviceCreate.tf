resource "harness_platform_service" "this" {
  identifier  = "gitxDemo"
  name        = "gitxDemo"
  org_id      = "default"
  project_id  = "rajTest"
  description = "gitxDemo Description"
  yaml        = <<-EOT
    service:
      name: gitxDemo
      identifier: gitxDemo
      description: "gitxDemo Description"
      tags: {}
      serviceDefinition:
        spec:
          artifacts:
            primary:
              primaryArtifactRef: <+input>
              sources:
                - name: test
                  identifier: test
                  template:
                    templateRef: account.TestCDS53213
                    versionLabel: "1"
                    templateInputs:
                      type: DockerRegistry
                      spec:
                        imagePath: <+input>
                        tag: <+input>
        type: Kubernetes
       EOT
}

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key = "pat.UKh5Yts7THSMAbccG3HrLA.631ad184015b135d5052742a.VsueShc2p2xD3abapFQG"
}
