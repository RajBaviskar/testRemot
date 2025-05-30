module "basic_example" {
  source = "git::https://github.com/RajBaviskar/testRemot.git//IaCM/module/basic?ref=main"

  name = "Raj"
}

output "greeting_output" {
  value = module.basic_example.greeting
}
