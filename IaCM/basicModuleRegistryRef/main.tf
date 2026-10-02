module "basic_example" {
  source  = "saas-central-devspace.harness-test.com/W_2ikBWEQjeB0BqokV3lTQ/basic/null"
  version = "1.0.0"

  name = "Raj"
}

output "greeting_output" {
  value = module.basic_example.greeting
}
