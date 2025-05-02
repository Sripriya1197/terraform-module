cluster_name = "my-prod-ecs-cluster"

tags = {
  Environment = "production"
  Owner       = "Sripriya"
}

cluster_settings = [
  {
    name  = "containerInsights"
    value = "enabled"
  }
]

cluster_configuration = {
  execute_command_configuration = {
    kms_key_id = null
    logging    = "DEFAULT"
    log_configuration = {
      cloud_watch_encryption_enabled = false
      cloud_watch_log_group_name     = "/ecs/my-prod-ecs-cluster"
    }
  }
}
