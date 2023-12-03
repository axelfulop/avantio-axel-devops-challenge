data "aws_iam_policy_document" "policy" {
  count = length(var.iam_policies)
  dynamic "statement" {
    for_each = var.iam_policies[count.index].statements
    content {
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
      dynamic "condition" {
        for_each = try(statement.value.conditions, [])
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}