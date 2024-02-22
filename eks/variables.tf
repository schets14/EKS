variable "master_subnet_ids" {
  type = list
}

variable "worker_subnet_ids" {
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
variable "ng_capacity_type" {
  type = string
}
variable "ng_disk_size" {
  type = string
}
variable "ng_instance_types" {
  type = list
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