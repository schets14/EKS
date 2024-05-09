resource "aws_s3_bucket" "eks_s3_bucket" {
  bucket = var.s3_bucket_name
  tags   = local.tags
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = module.vpc.private_route_table_ids
  vpc_endpoint_type = "Gateway"

  tags = local.tags
}
