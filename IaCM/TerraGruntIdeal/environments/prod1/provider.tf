terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }

  backend "local" {
    path = "../../../../terraform.tfstate"  # Reference the shared state file in the root
  }
}
