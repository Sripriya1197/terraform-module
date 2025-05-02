module "ecs_cluster" {
  source = "../../.modules/aws/ecs"
  cluster_name = "my-ecs-cluster"
  capacity_providers = ["FARGATE"]
  enable_managed_tags = true
  propagate_tags = "TASK_DEFINITION"
}

module "ecs_task_definition" {
  source = "../../.modules/aws/ecs"
  
  family                 = "my-ecs-task"
  container_definitions  = jsonencode([{
    name      = "my-ecr-container"
    image     = "273354669111.dkr.ecr.ap-south-1.amazonaws.com/github-action:1.1.1"
    portMappings = [{
      containerPort = 80
      protocol      = "tcp"
    }]
  }])
  cpu                    = "256"  
  memory                 = "512"  
  requires_compatibilities = ["FARGATE"]
  network_mode           = "awsvpc"
}

module "ecs_service" {
  source          = "../../.modules/aws/ecs"
  service_name    = "my-ecs-service" 
  ecs_cluster_id  = module.ecs_cluster.cluster_id  
  task_arn        = module.ecs_task_definition.task_definition_arn 
  count           = 1  
  fargate         = true  
  network_config  = {    
    subnets          = ["subnet-0697385b41cf20408"]
    security_groups  = ["sg-0ef52138839aef07e"]
    assign_public_ip = true
  }
}
