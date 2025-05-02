module "ecs" {
  source       = "terraform-aws-modules/ecs/aws"
  cluster_name = "my-ecs-cluster-tf"



  # Define the ECS service in the services block
  services = {
    github-app = {
      name            = "github-app"               
      cpu             = 256
      memory          = 512
      desired_count   = 1                        
      launch_type     = "FARGATE"                  
      
      # ECS container definitions
      container_definitions = jsonencode([{
        name         = "github-container"
        image        = "273354669111.dkr.ecr.ap-south-1.amazonaws.com/github-action:1.1.1"
        essential    = true
        portMappings = [
          {
            containerPort = 80
            protocol      = "tcp"
          }
        ]
      }])

      # Networking and security settings
      subnet_ids = ["subnet-0697385b41cf20408"]

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
