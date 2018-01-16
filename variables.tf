
variable "task_name" {}

variable "network_mode" {
  default = "bridge"
  description = "Allowed values: none, bridge, awsvpc, and host"
}

variable "task_role_policies" {
  type = "list"
  default = []
  description = "List of IAM policy ARNs to associate with task role"
}

variable "launch_type" {
  default = "EC2"
  description = ""
}

variable "container_name" {}

variable "image" {
  description = "Docker image URI in ECR. For example: 485555331535.dkr.ecr.eu-west-1.amazonaws.com/upm-shopit:0.1"
}

variable "memory_hard_limit" {
  default = 0
  description = "Container memory hard limit in MiB. By default, no limit is set."
}

variable "memory_soft_limit" {
  default = 0
  description = "Container memory soft limit in MiB. By default, no limit is set."
}

variable "port_mappings" {
  type = "list"
  default = []
}

variable "cpu" {
  default = ""
}

variable "essential" {
  default = true
}

variable "entryPoint" {
  type = "list"
  default = []
}

variable "command" {
  type = "list"
  default = []
}

variable "links" {
  type = "list"
  default = []
}

variable "environment" {
  type = "list"
  description = "Environment variables passed to the container"
  default = []
}

variable "privileged" {
  default = false
}

