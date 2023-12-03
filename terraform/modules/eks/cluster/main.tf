locals {
  basename = "${var.env}-${var.region}-eks-cluster"
}

resource "random_id" "resource" {
  keepers = {
    descriptor = var.descriptor
  }

  byte_length = 8
}

resource "aws_eks_cluster" "avantio_cluster" {
  name     = "${local.basename}${var.descriptor != "" ? format("-%s", lower(var.descriptor)) : ""}-${lower(random_id.resource.id)}"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids              = concat(var.public_subnet_ids, var.private_subnet_ids)
  }

  tags = merge({
    "Name" = "${local.basename}${var.descriptor != "" ? format("-%s", lower(var.descriptor)) : ""}-${lower(random_id.resource.id)}"
    },
  var.basetags)
}

module "nodegroup" {
  count  = length(var.node_groups)
  source = "../nodegroup"

  region = var.region

  env        = var.env

  basename = var.basename
  basetags = var.basetags

  desired_size       = var.node_groups[count.index].desired_size
  max_size           = var.node_groups[count.index].max_size
  min_size           = var.node_groups[count.index].min_size

  descriptor = var.node_groups[count.index].descriptor
  id         = lower(random_id.resource.id)

  cluster_name = aws_eks_cluster.avantio_cluster.name

  nodes_role_arn = var.nodes_role_arn

  subnet_ids = var.private_subnet_ids


}
