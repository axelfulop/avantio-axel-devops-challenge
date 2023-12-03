resource "aws_iam_policy" "custom" {
  count  = length(data.aws_iam_policy_document.policy)
  name   = "${var.env}-${var.region}-iam-policy-${lower(var.iam_policies[count.index].aws_resource)}${var.descriptor != "" ? format("-%s", lower(var.descriptor)) : ""}${var.role_id != "" ? format("-%s", lower(var.role_id)) : ""}"
  policy = data.aws_iam_policy_document.policy[count.index].json
}