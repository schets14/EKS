###################-----ECR REPO CREATION-----################
resource "aws_ecr_repository" "ecr_repo" {
 name                 = var.ecr_name
 tags    = {
	Name          = var.ecr_name
  }
}

##################------S3 CREATION-----######################

resource "aws_s3_bucket" "eks_s3_bucket" {
  bucket = var.s3_bucket_name  
  tags    = {
	Name          = var.s3_bucket_name
  }
}
###################------EFS CREATION------####################

resource "aws_efs_file_system" "eks-efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted = "true"
  tags = {
    Name = "eks-efs"
  }
}

