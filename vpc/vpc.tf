# Create VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.eks_vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.eks_vpc_name
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.eks_vpc_public_sub_cidr
  availability_zone       = var.eks_vpc_public_subnet_az
  map_public_ip_on_launch = true
  tags = {
    Name = "eks_public_subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.eks_vpc_private_sub_cidr
  availability_zone       = var.eks_vpc_private_subnet_az
  map_public_ip_on_launch = false
  tags = {
    Name = "eks_private_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks_ig"
  }
}

#route_table 
resource "aws_route_table" "eks_RT" {
 vpc_id =  aws_vpc.eks_vpc.id
 tags = {
   Name = "eks_vpc_rt"
 }
}

# Attach Internet Gateway to VPC
resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.eks_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks_igw.id
}

# Create a route table for the public subnet
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks_vpc_publicsub_RT"
  }
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

# Create a route table for the private subnet
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks_vpc_privatesub_RT"
  }
}

# Associate the private subnet with the route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}
