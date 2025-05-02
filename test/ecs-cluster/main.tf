module "ecs" {
  source       = "../../.modules/aws/ecs"
  cluster_name = "my-ecs-cluster"

  services = {
    github-app = {
      cpu    = 256
      memory = 512

      container_definitions = {
        github-container = {
          image     = "273354669111.dkr.ecr.ap-south-1.amazonaws.com/github-action:1.1.1"
          essential = true
          port_mappings = [
            {
              containerPort = 80
              protocol      = "tcp"
            }
          ]
        }
      }

      subnet_ids = [
        "subnet-0697385b41cf20408"
      ]

      security_group_rules = {
        allow_http = {
          type        = "ingress"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }

        allow_all_egress = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}
