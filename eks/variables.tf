variable "subnet_ids" {
  type = list
}

variable "vpc_id" {
   //default = "vpc-5f680722"
   type = string
}
variable "cluster_name" {
  type = string
}
variable "cluster_version" {
  type = string
}
variable "node_group_name" {
  type = string
}
variable "workernode_instance_type" {
  type = list
}
variable "workernode_min_size" {
  type = number
}
variable "workernode_max_size" {
  type = number
}
variable "workernode_desired_size" {
  type = string
}
