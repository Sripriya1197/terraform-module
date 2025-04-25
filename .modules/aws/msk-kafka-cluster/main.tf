module "msk-kafka-cluster" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"
  version = "2.11.1"
}