variable "environment" {
  description = "Environment name (qa/prod)"
  type        = string
}

output "message" {
  value = "Hello, World from Terragrunt ${var.environment}!"
}
