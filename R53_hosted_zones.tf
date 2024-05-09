resource "aws_route53_zone" "my_hosted_zone" {
  name = var.domain_name # replace with your desired domain name
  vpc {
    vpc_id = module.vpc.vpc_id # replace with your VPC id
  }
}