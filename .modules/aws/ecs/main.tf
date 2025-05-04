module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.12.1"

  cluster_name = "my-ecs-tf-cluster"
create_cloudwatch_log_group = false 
  services     = var.services
 
}
