module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version #"1.28"

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = var.node_group_name

      instance_types = var.workernode_instance_type #["t3.small"]

      min_size     = var.workernode_min_size #1
      max_size     = var.workernode_max_size #2
      desired_size = var.workernode_desired_size #2
    }
  }
}