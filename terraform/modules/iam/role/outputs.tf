# output "assume_role_policy" {
#     value = data.aws_iam_policy_document.assume_role_policy
# }

output "role_arn" {
  value = aws_iam_role.cp2.arn
}