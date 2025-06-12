variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = true

}

variable "create" {
  description = "Whether to create the resources"
  type        = bool
  default     = true
}

variable "services" {
  description = "Map of ECS service definitions"
  type        = any
  default     = true
}
