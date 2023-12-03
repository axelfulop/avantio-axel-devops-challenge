data "aws_iam_policy_document" "assume_role_policy" {
    dynamic "statement" {
        for_each = var.assume_role_policy.statements
        content {
            actions = statement.value.actions
            principals {
                type = statement.value.type
                identifiers = statement.value.identifiers
            }
        }
    }
}