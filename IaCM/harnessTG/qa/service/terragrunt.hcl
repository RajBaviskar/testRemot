include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

generate "main" {
  path      = "main.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
resource "harness_platform_service" "qa" {
  identifier   = "rajK8NativeTF2qa"
  name         = "rajK8NativeTF2qa"
  org_id       = "default"
  project_id   = "rajTest"
  yaml         = <<-EOH
service:
  name: rajK8NativeTF2qa
  identifier: rajK8NativeTF2qa
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

output "qa_service_id" {
  value = harness_platform_service.qa.id
}
EOF
}
