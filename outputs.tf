# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "A list of private subnets inside the VPC"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "A list of public subnets inside the VPC"
  value       = module.vpc.public_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}
output "jump_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "s3_name" {
  value = aws_s3_bucket.eks_s3_bucket.tags_all
}

output "aws_eks_cluster_id" {
  value = aws_eks_cluster.eks.cluster_id
}

output "aws_eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
output "efs_id" {
  value = aws_efs_file_system.eks-efs.id
}
