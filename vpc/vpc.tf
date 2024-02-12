
###################------VPC CREATION------#########################
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.eks_vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.eks_vpc_name
  }
}

###################--------CREATION OF PUBLIC SUBNET 1-----############
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.eks_vpc_public_sub_1_cidr
  availability_zone       = var.eks_vpc_public_subnet_1_az # Change this to your desired availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "EKS_public_subnet_1"
  }
}
###################--------CREATION OF PUBLIC SUBNET 2-----############
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.eks_vpc_public_sub_2_cidr
  availability_zone       = var.eks_vpc_public_subnet_2_az # Change this to your desired availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "EKS_public_subnet_2"
  }
}

###################--------CREATION OF PRIVATE SUBNET 1-----############
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.eks_vpc_private_sub_1_cidr
  availability_zone       = var.eks_vpc_private_subnet_1_az # Change this to your desired availability zone
  tags = {
    Name = "EKS_private_subnet_1"
  }
}
###################--------CREATION OF PRIVATE SUBNET 2-----############
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.eks_vpc_private_sub_2_cidr
  availability_zone       = var.eks_vpc_private_subnet_2_az # Change this to your desired availability zone
  tags = {
    Name = "EKS_private_subnet_2"
  }
}

###################--------CREATION OF IGW-----#########################
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "EKS_vpc_igw"
  }
}

##########--------CREATION OF ROUTE TABLE FOR PUBLIC SUBNET-----###########
resource "aws_route_table" "eks_pub_RT" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
}
##########--------CREATION OF ROUTE TABLE FOR PRIVATE SUBNET-----###########
resource "aws_route_table" "eks_pvt_RT" {
  vpc_id = aws_vpc.eks_vpc.id
}

##########--------ASSOCIATE ROUTE TABLE TO PUBLIC SUBNET-------##############
resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.eks_pub_RT.id
}
##########--------ASSOCIATE ROUTE TABLE TO PUBLIC SUBNET-------##############
resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.eks_pub_RT.id
}
##########--------ASSOCIATE ROUTE TABLE TO PRIVATE SUBNET-------##############
resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.eks_pvt_RT.id
}
##########--------ASSOCIATE ROUTE TABLE TO PRIVATE SUBNET-------##############
resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.eks_pvt_RT.id
}

#################--------ELASTIC IP FOR NAT GATEWAY------######################
resource "aws_eip" "nat" {
  domain = "vpc"
}
###############-----------NAT GATEWAY CREATION-----------######################
resource "aws_nat_gateway" "eks_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "EKS_nat Gateway"
  }
}
##############------NAT GATEWAY ROUTE TO INTERNET---------#####################
resource "aws_route" "route_to_nat" {
  route_table_id         = aws_route_table.eks_pvt_RT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eks_nat.id
}
###############################################################################