resource "harness_platform_service" "this" {
  identifier   = "rajK8NativeTF2"
  name         = "rajK8NativeTF2"
  org_id       = "default"
  project_id   = "rajTest"

  yaml = <<-EOH
service:
  name: rajK8NativeTF2
  identifier: rajK8NativeTF2
  orgIdentifier: default
  projectIdentifier: rajTest
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

output "out" {
  value = harness_platform_service.this.id
}

