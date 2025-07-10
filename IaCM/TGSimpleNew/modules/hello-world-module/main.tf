# Empty backend block for Terragrunt to configure
terraform {
  backend "local" {}
}

variable "environment" {
  description = "Environment name (qa/prod)"
  type        = string
}

variable "module_name" {
  description = "Name of the module"
  type        = string
  default     = "hello-world-module"
}

output "message" {
  value = "Hello, World from ${var.module_name} in ${var.environment}!"
}
