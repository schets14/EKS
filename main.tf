module "eks_vpc" {
    source = "./vpc"
    eks_vpc_name = "eks_vpc"
    eks_vpc_cidr = "10.0.0.0/16"
    eks_vpc_public_sub_cidr = "10.0.1.0/24"
    eks_vpc_public_subnet_az = "ap-south-1a"
    eks_vpc_private_sub_cidr = "10.0.2.0/24"
    eks_vpc_private_subnet_az = "ap-south-1b"
}
module "jump_server" {
    source = "./jump-server"
    jump_ami_id = "ami-03f4878755434977f"
    jump_instance_type = "t2.micro"
    jump_key_name = "my-jenkins"
    subnet_id = module.eks_vpc.public_subnet_id

}
module "eks" {
    source = "./eks"
    sg_ids = module.worker_sg.security_group_public
    subnet_ids = [module.eks_vpc.private_subnet_id,module.eks_vpc.public_subnet_id]
    vpc_id = module.eks_vpc.vpc_id
    eks_master_role = "eks_master_role"
    eks_worker_role = "eks_worker_role"
    eks_autoscale_role = "eks_autoscaler_role"
    eks_ebs_role = "eks_ebs_role"
    eks_cluster_name = "my_eks_cluster"
}
module "worker_sg" {
    source = "./worker-node"
    vpc_id = module.eks_vpc.vpc_id
}