resource "harness_platform_service" "this" {
  identifier   = "rajK8NativeTF2"
  name         = "rajK8NativeTF2"
  org_id       = "Ng_Pipelines_K8s_Organisations"
  project_id   = "DoNotDelete_Mayank"
  yaml         = <<-EOH
service:
  name: rajK8NativeTF2
  identifier: rajK8NativeTF2
  orgIdentifier: Ng_Pipelines_K8s_Organisations
  projectIdentifier: DoNotDelete_Mayank
  serviceDefinition:
    spec:
      manifests:
        - manifest:
            identifier: nativek8
            type: K8sManifest
            spec:
              store:
                type: Github
                spec:
                  connectorRef: account.rajAccountGithub
                  gitFetchType: Branch
                  paths:
                    - kubernetes/native
                  repoName: testRemot
                  branch: main
              skipResourceVersioning: false
              enableDeclarativeRollback: false
      artifacts:
        primary:
          primaryArtifactRef: <+input>
          sources:
            - spec:
                connectorRef: rajharnessdev
                imagePath: harnessdev/rajtodoapp
                tag: "4"
                digest: ""
              identifier: todofrompipeline
              type: DockerRegistry
    type: Kubernetes
  EOH
}
