#------------------------------------Provider variables---------------------------------------#
variable "region" {
  description = "Region where infra is to be created"
  default     = "ap-south-1"
}
#----------------------------------------VPC variables----------------------------------------#
# VPC Name
variable "name" {
  description = "VPC Name"
  type        = string
  default     = "vpc"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = ""
}
# Business Division
variable "owners" {
  description = "organization this Infrastructure belongs"
  type        = string
  default     = ""
}

# VPC CIDR Block
variable "cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

# VPC Public Subnets
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
# VPC Enable NAT Gateway (True or False) 
variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}
#---------------------------------------EKS configurations------------------------------------------------#
variable "eks_master_role" {
  type = string
}

variable "eks_worker_role" {
  type = string
}

variable "eks_autoscale_role" {
  type = string
}

variable "eks_ebs_role" {
  type = string
}
variable "eks_cluster_name" {
  type = string
}
variable "eks_endpoint_public_access" {
  type        = bool
  description = "EKS Cluster Endpoint Public access: true or false"
}
variable "aws_profile" {
  description = "AWS profile to use for authentication"
  type        = string
  default     = "default"
}
variable "ng_capacity_type" {
  type = string
}
variable "ng_disk_size" {
  type = string
}
variable "ng_instance_types" {
  type = list(any)
}
variable "eks_version" {
  type = string
}
variable "ng_desired_size" {
  type = number
}
variable "ng_max_size" {
  type = number
}
variable "ng_min_size" {
  type = number
}
#---------------------------------------Node Group 1-------------------------------------------------------#
variable "ng_1_capacity_type" {
  type = string
}
variable "ng_1_disk_size" {
  type = string
}
variable "ng_1_instance_types" {
  type = list(any)
}
variable "ng_1_desired_size" {
  type = number
}
variable "ng_1_max_size" {
  type = number
}
variable "ng_1_min_size" {
  type = number
}
#---------------------------------------S3 bucket configurations-------------------------------------------#
variable "s3_bucket_name" {
  description = "s3 bucket name"
  default     = "my-s3-bucket-18908392"
}
#---------------------------------------Jump-server configurations-------------------------------------------#
variable "jump_ami_id" {
  description = "ami id of jump server, changes according to region"
  default     = ""
}
variable "jump_instance_type" {
  description = "jump server instance type"
  default     = "t2.micro"
}
variable "jump_key_name" {
  description = "key for jump server creation"
  default     = ""
}
#-----------------------------R53------------------------------#
variable "domain_name" {
  type        = string
  description = "Enter your domain name"
}