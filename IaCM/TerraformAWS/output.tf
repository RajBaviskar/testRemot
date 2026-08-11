output "instance_ids" {
  description = "The IDs of the created EC2 instances"
  value       = aws_instance.example[*].id
}

output "public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.example[*].public_ip
}
