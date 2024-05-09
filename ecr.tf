resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = local.name
  image_tag_mutability = "MUTABLE"
  tags                 = local.tags

  image_scanning_configuration {
    scan_on_push = false
  }
}
