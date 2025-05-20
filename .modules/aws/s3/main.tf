module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.7.0"
}
resource "aws_s3_bucket" "this" {
  bucket = var.bucket
  acl    = var.acl
  tags   = var.tags
}