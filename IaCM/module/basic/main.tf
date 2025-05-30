variable "name" {
  type        = string
  description = "Name to greet"
}

output "greeting" {
  value = "Hello, ${var.name}!"
}
