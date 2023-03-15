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
           manifests:
            - manifest:
                identifier: ManifestName
                type: Values
                spec:
                    store:
                        type: Github
                        spec:
                            connectorRef: account.NGTerraformGitDriven
                            gitFetchType: Branch
                            paths:
                                - .
                            branch: main
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
