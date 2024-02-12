output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.eks_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.eks_pub_RT.id
}

output "private_route_table_id" {
  value = aws_route_table.eks_pvt_RT.id
}