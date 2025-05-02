module "ecs_cluster" {
  source = "../../.modules/aws/ecs"
  name               = "my-ecs-cluster"
  capacity_providers = ["FARGATE"]
  create_cluster     = true
}

module "ecs_task_definition" {
  source = "../../.modules/aws/ecs"
  family = "myapp-task"
  container_definitions = jsonencode([{
    name      = "my-container"
    image     = "your-ecr-repo-url:latest" # Replace with your actual image URL
    essential = true
    portMappings = [{
      containerPort = 80
      protocol      = "tcp"
    }]
  }])
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

module "ecs_service" {
  source          = "../../.modules/aws/ecs"
  name            = "myapp-service"
  cluster         = module.ecs_cluster.cluster_id
  task_definition = module.ecs_task_definition.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration = {
    subnets          = ["subnet-0697385b41cf20408"] # Your subnet ID here
    security_groups  = ["sg-0ef52138839aef07e"]     # Your security group ID here
    assign_public_ip = true
  }
}
