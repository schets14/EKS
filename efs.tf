resource "aws_efs_file_system" "eks-efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags             = local.tags
}
resource "aws_efs_mount_target" "efs_mount" {
  file_system_id = aws_efs_file_system.eks-efs.id
  count          = length(module.vpc.private_subnets)
  subnet_id      = module.vpc.private_subnets[count.index]
}