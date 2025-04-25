module "delegation_sets" {
  source  = "terraform-aws-modules/route53/aws//modules/delegation-sets"
  version = "~> 2.0"
}