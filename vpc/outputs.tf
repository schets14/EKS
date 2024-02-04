output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public_subnet_route_table_id" {
  value = aws_route_table.public_subnet_route_table.id
}

output "private_subnet_route_table_id" {
  value = aws_route_table.private_subnet_route_table.id
}