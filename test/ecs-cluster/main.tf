module "ecs_cluster" {
  source = "../../.modules/aws/ecs"
  
  cluster_name = "my-ecs-cluster"
  capacity_providers = ["FARGATE"] # Check if this is a valid argument for your module
  enable_managed_tags = true
  propagate_tags = "TASK_DEFINITION" # Ensure this is valid
}

module "ecs_task_definition" {
  source = "../../.modules/aws/ecs"
  
  family = "my-ecs-task"
  container_definitions = jsonencode([{
    name      = "my-ecs-container"
    image     = "273354669111.dkr.ecr.ap-south-1.amazonaws.com/github-action:1.1.1"
    essential = true
    portMappings = [{
      containerPort = 80
      protocol      = "tcp"
    }]
  }])

  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

module "ecs_service" {
  source = "../../.modules/aws/ecs"
  
  name             = "my-ecs-service"
  cluster          = module.ecs_cluster.cluster_id  # Update `ecs_cluster_id` to `cluster` or the correct name
  task_definition  = module.ecs_task_definition.task_definition_arn  # Ensure this is the correct reference
  desired_count    = 1
  launch_type      = "FARGATE"
  
  network_configuration = {
    subnets          = ["subnet-0697385b41cf20408"]
    security_groups  = ["sg-0ef52138839aef07e"]
    assign_public_ip = true
  }
}
