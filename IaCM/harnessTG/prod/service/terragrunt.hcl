include {
  path = find_in_parent_folders()
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "harness" {
  alias             = "prod"
  endpoint          = "https://app.harness.io/gateway"
  account_id        = "UKh5Yts7THSMAbccG3HrLA"
  platform_api_key  = ""
}
EOF
}

generate "main" {
  path      = "main.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
resource "harness_platform_service" "prod" {
  provider     = harness.prod
  identifier   = "rajK8NativeTF2prod"
  name         = "rajK8NativeTF2prod"
  org_id       = "default"
  project_id   = "rajTest"
  yaml         = <<-EOH
service:
  name: rajK8NativeTF2prod
  identifier: rajK8NativeTF2prod
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

output "prod_service_id" {
  value = harness_platform_service.prod.id
}
EOF
}
