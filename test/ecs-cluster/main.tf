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
      
      module "ecs" {
  source       = "terraform-aws-modules/ecs/aws"
  cluster_name = "my-ecs-cluster"  # Reference to your ECS cluster

  services = {
    github-app = {
      name            = "github-app"            # ECS service name
      cpu             = 256
      memory          = 512
      desired_count   = 1                       # Number of task instances
      launch_type     = "FARGATE"               # Fargate to run containers without EC2 instances
      task_role_arn   = "arn:aws:iam::your-account-id:role/ecsTaskExecutionRole"  # Ensure the role is correct

      # Container Definitions (correct format as a list of maps)
      container_definitions = [
        {
          name         = "github-container"
          image        = "273354669111.dkr.ecr.ap-south-1.amazonaws.com/github-action:1.1.1"
          essential    = true
          portMappings = [
            {
              containerPort = 80
              protocol      = "tcp"
            }
          ]
        }
      ]

      # Networking: define subnets, security groups, and VPC (ensure these IDs exist)
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
