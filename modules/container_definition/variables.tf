variable "name" {
  description = "Container name"
}

variable "image" {
  description = <<EOF
The image used to start a container. This string is passed directly to the Docker daemon.
Images in the Docker Hub registry are available by default. Images in Amazon ECR repositories
can be specified by using either the full registry/repository:tag or registry/repository@digest naming convention.
EOF
}

variable "mem_hard_limit" {
  description = <<EOF
The hard limit (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed
You must specify a non-zero integer for one or both of mem_hard_limit or mem_soft_limit
EOF
  default     = 0
}

variable "mem_soft_limit" {
  default     = 0
  description = <<EOF
The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention,
Docker attempts to keep the container memory to this soft limit. You must specify a non-zero integer for one
or both of memory or memoryReservation in container definitions
EOF
}

variable "port_mappings" {
  description = <<EOF
Container port to host port mapping. Example:
"portMappings": [
  {
    "containerPort": 8080,
    "hostPort": 80
  }
]
EOF
  type        = "list"
  default     = []
}

variable "cpu" {
  description = "The number of cpu units to reserve for the container"
  default     = ""
}

variable "essential" {
  description = "If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped."
  default     = true
}

variable "entry_point" {
  description = "The entry point that is passed to the container"
  type        = "list"
  default     = []
}

variable "command" {
  description = "The command that is passed to the container"
  type        = "list"
  default     = []
}

variable "links" {
  description = "The link parameter allows containers to communicate with each other without the need for port mappings"
  type        = "list"
  default     = []
}

variable "environment" {
  description = <<EOF
Environment variables passed to the container. Example:
"environment" : [
    { "name" : "string", "value" : "string" },
    { "name" : "string", "value" : "string" }
]
EOF
  type        = "list"
  default     = []
}

variable "privileged" {
  description = "When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user)"
  default     = false
}

variable "log_group_name" {
  description = "Log group to which the awslogs log driver will send its log streams"
  default = ""
}

variable "log_stream_prefix" {
  description = "Log stream prefix. Defaults to value $${var.name} if not specified"
  default     = ""
}