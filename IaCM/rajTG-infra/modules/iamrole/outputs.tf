output "role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.ec2_role.name
}

output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.ec2_role.arn
}

output "policy_arn" {
  description = "ARN of the S3 access policy"
  value       = aws_iam_policy.s3_policy.arn
}
