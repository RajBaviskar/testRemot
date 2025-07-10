terraform {
  source = "../hello-world-module"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "Prod"
}
