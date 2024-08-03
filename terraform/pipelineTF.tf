resource "harness_platform_pipeline" "example" {
  identifier = "VeryBigPipelineTest"
  org_id     = "default"
  project_id = "rajTest"
  name       = "VeryBigPipelineTest"
  yaml = <<-EOT
  pipeline:
  name: VeryBigPipe
  identifier: VeryBigPipe
  projectIdentifier: rajTest
  orgIdentifier: default
  tags: {}
  stages:
    - stage:
        name: stage1
        identifier: stage1
        tags: {}
        template:
          templateRef: asfsdfd
          versionLabel: "1"
          templateInputs:
            type: Deployment
            spec:
              environment:
                environmentRef: <+input>
                environmentInputs: <+input>
                serviceOverrideInputs: <+input>
                infrastructureDefinitions: <+input>
              service:
                serviceRef: <+input>
                serviceInputs: <+input>
    - stage:
        name: stage2
        identifier: stage2
        tags: {}
        template:
          templateRef: fdsg
          versionLabel: "1"
          templateInputs:
            type: Deployment
            spec:
              service:
                serviceInputs:
                  serviceDefinition:
                    type: Kubernetes
                    spec:
                      artifacts:
                        primary:
                          primaryArtifactRef: <+input>
                          sources: <+input>
    - stage:
        name: stage3
        identifier: stage3
        tags: {}
        template:
          templateRef: helmDeploy
          versionLabel: v1
          templateInputs:
            type: Deployment
            spec:
              service:
                serviceRef: <+input>
                serviceInputs: <+input>
              environment:
                environmentRef: <+input>
                infrastructureDefinitions: <+input>
                environmentInputs: <+input>
                serviceOverrideInputs: <+input>
              execution:
                steps:
                  - stepGroup:
                      identifier: deployContainers
                      steps:
                        - step:
                            identifier: chartDeploymentBarrier
                            type: Barrier
                            spec:
                              barrierRef: <+input>
                  - stepGroup:
                      identifier: verifyService
                      steps:
                        - step:
                            identifier: chartTestingComplete
                            type: Barrier
                            spec:
                              barrierRef: <+input>
            variables:
              - name: Chart_Version
                type: String
                value: <+input>
            when:
              condition: <+input>
    - stage:
        name: stage4
        identifier: stage4
        tags: {}
        template:
          templateRef: sdgfgghgh
          versionLabel: "1"
          templateInputs:
            type: Deployment
            spec:
              service:
                serviceRef: <+input>
                serviceInputs: <+input>
              environment:
                environmentRef: <+input>
                environmentInputs: <+input>
                serviceOverrideInputs: <+input>
                infrastructureDefinitions: <+input>
    - stage:
        name: stage5
        identifier: stage5
        tags: {}
        template:
          templateRef: CDS74562remoteTemp
          versionLabel: "2"
  EOT
}
