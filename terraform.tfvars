# Generic Variables
region      = "us-west-2"
environment = "sandbox"
owners      = "chetan"


# VPC Variables
name               = "vpc-terraform" # Overridning the name defined in variable file
cidr               = "10.0.0.0/16"
azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
enable_nat_gateway = true
single_nat_gateway = true

# S3 bucket
s3_bucket_name = "chetansssola-bucket-s3"

#EKS
eks_version        = "1.28"
eks_master_role    = "eks_master_role"
eks_worker_role    = "eks_worker_role"
eks_autoscale_role = "eks_autoscaler_role"
eks_ebs_role       = "eks_ebs_role"
eks_cluster_name   = "my_eks_cluster"
eks_endpoint_public_access = true
#NG-0
ng_instance_types = ["t2.medium"]
ng_min_size       = 2
ng_max_size       = 2
ng_desired_size   = 2
ng_capacity_type  = "ON_DEMAND"
ng_disk_size      = "10"
#NG-1
ng_1_instance_types = ["t2.medium"]
ng_1_min_size       = 2
ng_1_max_size       = 2
ng_1_desired_size   = 2
ng_1_capacity_type  = "ON_DEMAND"
ng_1_disk_size      = "10"
#Jump Server
jump_ami_id        = "ami-08116b9957a259459"
jump_instance_type = "t2.micro"
jump_key_name      = "terra"
#ROUTE53 DNS CONFIGURATIONS
domain_name = "chetansolanki.xyz"