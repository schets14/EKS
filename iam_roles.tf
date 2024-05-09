#---------------------------------EKS MASTER ROLE CREATION--------------------------------------#
resource "aws_iam_role" "eks_master" {
  name = "${local.name}-eks_master_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#-----------------------------------EKS MASTER ROLE POLICY ATTACHMENT---------------------------------------#

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_master.name
}

#-----------------------------------EKS WORKER NODE ROLE CREATION--------------------------------------#

resource "aws_iam_role" "eks_worker" {
  name = "${local.name}-eks_worker_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#--------------------------------------WORKER NODE AUTOSCALER-------------------------------------#

resource "aws_iam_policy" "autoscaler" {
  name   = "${local.name}-eks_ng_autoscaler"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeTags",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
#-----------------------------------------EBS POLICY---------------------------------------------#

resource "aws_iam_policy" "ebs_access_policy" {
  name        = "${local.name}-EBSAccessPolicy"
  description = "IAM policy for EBS access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DescribeVolumeAttribute",
        "ec2:DescribeVolumeStatus",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:DescribeVolumes",
        "ec2:ModifyVolume",
        "ec2:DescribeVolumeAttribute",
        "ec2:DescribeVolumeStatus"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

#--------------------------------------EFS POLICY-----------------------------------------#

resource "aws_iam_policy" "efs_access_policy" {
  name        = "${local.name}-EFSAccessPolicy"
  description = "IAM policy for EFS access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:ClientMount",
        "elasticfilesystem:ClientWrite"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

#-----------------------------------WORKER NODE ROLE POLICY ATTACHMENT---------------------------------------------#

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "autoscaler" {
  policy_arn = aws_iam_policy.autoscaler.arn
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "ebs-policy" {
  policy_arn = aws_iam_policy.ebs_access_policy.arn
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_role_policy_attachment" "efs-policy" {
  policy_arn = aws_iam_policy.efs_access_policy.arn
  role       = aws_iam_role.eks_worker.name
}

resource "aws_iam_instance_profile" "worker" {
  depends_on = [aws_iam_role.eks_worker]
  name       = "eks_instance_profile"
  role       = aws_iam_role.eks_worker.name
}
