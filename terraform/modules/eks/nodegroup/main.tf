locals {
  basename = "${var.env}-${var.region}-eks-nodegroup"
}

resource "random_id" "resource" {
  keepers = {
    descriptor = var.descriptor
  }

  byte_length = 8
}

resource "aws_eks_node_group" "cp2" {
  cluster_name = var.cluster_name
  node_group_name = "${local.basename}${var.descriptor != "" ? format("-%s", lower(var.descriptor)) : ""}-${var.id != "" ? var.id : lower(random_id.resource)}"
  node_role_arn = var.nodes_role_arn
  subnet_ids = var.subnet_ids

  instance_types = ["t2.small"]

  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
  }

  update_config {
    max_unavailable = 1
  }
}