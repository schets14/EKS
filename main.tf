module "eks_vpc" {
  source = "./vpc"
  eks_vpc_name = "EKS_VPC"
  eks_vpc_cidr = "10.0.0.0/16"
  eks_vpc_public_sub_1_cidr = "10.0.1.0/24"
  eks_vpc_public_subnet_1_az = "ap-south-1a"
  eks_vpc_private_sub_1_cidr = "10.0.2.0/24"
  eks_vpc_private_subnet_1_az = "ap-south-1a"
  eks_vpc_public_sub_2_cidr = "10.0.3.0/24"
  eks_vpc_public_subnet_2_az = "ap-south-1b"
  eks_vpc_private_sub_2_cidr = "10.0.4.0/24"
  eks_vpc_private_subnet_2_az = "ap-south-1b"
}
module "jump-server" {
  source = "./jump-server"
  jump_vpc_id = module.eks_vpc.vpc_id
  jump_ami_id = "ami-03f4878755434977f"
  jump_instance_type = "t2.micro"
  jump_key_name = "my-jenkins"
  jump_subnet_id = module.eks_vpc.public_subnet_ids[1]
}
module "eks" {
  source             = "./eks"
  subnet_ids         = [module.eks_vpc.private_subnet_ids[0], module.eks_vpc.private_subnet_ids[1]]
  vpc_id             = module.eks_vpc.vpc_id
  cluster_name   = "my_eks_cluster"
  cluster_version = "1.28"
  node_group_name = "worker-node"
  workernode_instance_type = ["t2.micro"]
  workernode_min_size = 1
  workernode_max_size = 2
  workernode_desired_size = 2
}

module "ecs-efs-s3" {
  source = "./ecr-efs-s3"
  ecr_name =  "demo"
  s3_bucket_name = "my-eks-demo-project2222310-b"
}