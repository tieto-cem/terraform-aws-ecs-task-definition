
variable "name" {
  description = "Name of the task definition"
}

variable "container_definitions" {
  description = "List of container definitions"
  type = "list"
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host"
  default = "bridge"
}

variable "role_policies" {
  description = "List of IAM policy ARNs to associate with task role"
  type = "list"
  default = []
}


