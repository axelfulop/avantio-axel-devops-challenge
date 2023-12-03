locals {
  basename = "${var.env}-${var.region}-iam-role"
}

resource "random_id" "resource" {
  keepers = {
    descriptor = var.descriptor
  }

  byte_length = 8
}

resource "aws_iam_role" "cp2" {
  name               = "${local.basename}${var.descriptor != "" ? format("-%s", lower(var.descriptor)) : ""}-${lower(random_id.resource.id)}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  depends_on = [
    random_id.resource
  ]
}

module "custom_iam_policies" {
  source       = "../policy"

  basename     = var.basename
  basetags     = var.basetags

  descriptor = var.descriptor
  role_id = random_id.resource.id

  iam_policies = var.custom_iam_policies

  depends_on = [
    random_id.resource
  ]
}

resource "aws_iam_role_policy_attachment" "legacy" {
  count      = length(var.legacy_iam_policies)
  role       = aws_iam_role.cp2.name
  policy_arn = var.legacy_iam_policies[count.index]

  depends_on = [
    aws_iam_role.cp2
  ]
}

resource "aws_iam_role_policy_attachment" "custom" {
  count      = length(module.custom_iam_policies.policies_arn)
  role       = aws_iam_role.cp2.name
  policy_arn = module.custom_iam_policies.policies_arn[count.index]

  depends_on = [
    aws_iam_role.cp2,
    module.custom_iam_policies
  ]
}