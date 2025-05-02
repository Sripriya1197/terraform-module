module "ecs_cluster" {
  source = "../../.modules/aws/ecs"
  
   cluster_name = "my-ecs-cluster"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "my-ecs-cluster-logs" 
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "MyAppProject"
  }
}

module "ecs_container_definition" {
  source = "../../.modules/aws/ecs"
  
  name      = "my-container"
  cpu       = 256
  memory    = 512
  essential = true
  image = "273354669111.dkr.ecr.ap-south-1.amazonaws.com/github-action:1.1.1"
    port_mappings = [
    {
      name          = "my-container-port"
      containerPort = 80
      protocol      = "tcp"
    }
  ]
}

module "ecs_service" {
  source          = "../../.modules/aws/ecs"
  service_name    = "my-ecs-service"  
  cluster_id      = module.ecs_cluster.cluster_id  
  task_definition = module.ecs_container_definition.task_definition_arn  
  desired_count   = 1  
  launch_type     = "FARGATE" 

  network_configuration = {
    subnets          = ["subnet-0697385b41cf20408"]  
    security_groups  = ["sg-0ef52138839aef07e"]     
    assign_public_ip = true  
  }
}
