###########################----EKS CLUSTER CREATION----##############################################

resource "aws_eks_cluster" "eks" {
  name     = "${local.name}-cluster"
  version  = var.eks_version
  role_arn = aws_iam_role.eks_master.arn

  vpc_config {
    subnet_ids              = module.vpc.private_subnets
    endpoint_public_access  = var.eks_endpoint_public_access
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    #aws_subnet.pub_sub1,
    #aws_subnet.pub_sub2,
  ]

}
data "aws_eks_cluster" "eks" {
  name       = "${local.name}-cluster"
  depends_on = [aws_eks_cluster.eks]
}

data "aws_eks_cluster_auth" "eks" {
  name       = "${local.name}-cluster"
  depends_on = [aws_eks_cluster.eks]
}
#############################----EKS NODE GROUP CREATION----###############################################

resource "aws_eks_node_group" "eks_ng" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${local.name}-ng"
  node_role_arn   = aws_iam_role.eks_worker.arn
  subnet_ids      = module.vpc.private_subnets
  capacity_type   = var.ng_capacity_type  #"ON_DEMAND"
  disk_size       = var.ng_disk_size      #"10"
  instance_types  = var.ng_instance_types #["t2.micro"]

  labels = tomap({ env = "eks" })

  scaling_config {
    desired_size = var.ng_desired_size #2
    max_size     = var.ng_max_size
    min_size     = var.ng_min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    #aws_subnet.pub_sub1,
    #aws_subnet.pub_sub2,
  ]
}
#-----------------------------------------NODE GROUP 2-----------------------------------------------#
resource "aws_eks_node_group" "eks_ng_1" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${local.name}-ng-1"
  node_role_arn   = aws_iam_role.eks_worker.arn
  subnet_ids      = module.vpc.private_subnets
  capacity_type   = var.ng_1_capacity_type  #"ON_DEMAND"
  disk_size       = var.ng_1_disk_size      #"10"
  instance_types  = var.ng_1_instance_types #["t2.micro"]

  labels = tomap({ env = "eks" })

  scaling_config {
    desired_size = var.ng_1_desired_size #2
    max_size     = var.ng_1_max_size
    min_size     = var.ng_1_min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    #aws_subnet.pub_sub1,
    #aws_subnet.pub_sub2,
  ]
}
####################################################################################################################################################