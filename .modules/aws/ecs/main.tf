module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.0"

  cluster_name              = var.cluster_name
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  create                    = var.create

  services = var.services
}

