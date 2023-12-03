module "eks" {

  source             = "../../modules/eks/cluster"
  env                = var.env
  region             = var.region
  cluster_role_arn   = aws_iam_role.eks.arn
  nodes_role_arn     = aws_iam_role.node_group.arn
  public_subnet_ids  = [module.avantio-vpc.public_subnet_1_id, module.avantio-vpc.public_subnet_2_id]
  private_subnet_ids = [module.avantio-vpc.private_subnet_1_id, module.avantio-vpc.private_subnet_2_id]
  node_groups = [
    {
      desired_size = 1
      max_size     = 1
      min_size     = 1
      descriptor   = "foo"
    }
  ]

  depends_on = [aws_iam_role.eks,
    aws_iam_role.node_group,
    module.avantio-vpc,
  aws_iam_role.node_group]


}
