# eks vpc name
variable "eks_vpc_name" {
    description = "eks vpc name"
}

# eks vpc cidr block range
variable "eks_vpc_cidr" {
    description = "CIDR block for VPC"
}

# eks vpc public subnet cidr block range
variable "eks_vpc_public_sub_cidr" {
    description = "CIDR block for public subnet"
}

# eks vpc public subnet availability zone name
variable "eks_vpc_public_subnet_az" {
    description = "Availability zone for public subnet"
}

# eks vpc private subnet cidr block range
variable "eks_vpc_private_sub_cidr" {
    description = "CIDR block for private subnet"
}

# eks vpc private subnet availability zone name
variable "eks_vpc_private_subnet_az" {
    description = "Availability zone for private subnet"
}