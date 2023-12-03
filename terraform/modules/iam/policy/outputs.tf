output "policies_arn" {
  value = aws_iam_policy.custom.*.arn
}

output "policies" {
  value = aws_iam_policy.custom.*.policy
}