variable "sg_ids" {
type = string
}

variable "subnet_ids" {
  type = list
}

variable "vpc_id" {
   //default = "vpc-5f680722"
   type = string
}

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