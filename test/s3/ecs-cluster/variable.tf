variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "tags" {
  type = map(string)
}

variable "cluster_settings" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "cluster_configuration" {
  type = any
}
