output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.example.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
