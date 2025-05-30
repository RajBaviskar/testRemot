provider "aws" {
  region = "us-east-1"  # or use a variable
}

module "my_custom_module" {
  source = "git::https://github.com/RajBaviskar/testRemot.git//IaCM/module?ref=main"

  # Pass any required variables your module expects
  name = "demo"         # Example variable, update based on your module
  cidr = "10.1.0.0/16"  # Example
}
