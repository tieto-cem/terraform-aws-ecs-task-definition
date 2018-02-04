
output "json" {
  description = "Container definition in JSON format"
  value = <<EOF
{
  "name": "${var.name}",
  "image": "${var.image}",
  ${var.mem_hard_limit == 0 ? "" : "\"memory\": ${var.mem_hard_limit},"}
  ${var.mem_soft_limit == 0 ? "" : "\"memoryReservation\": ${var.mem_soft_limit},"}
  "portMappings": ${replace(jsonencode(var.port_mappings), "/\"(?P<port>\\d+)\"/", "$port")},
  ${var.cpu == "" ? "" : "\"cpu\": ${var.cpu},"}
  "essential": ${var.essential ? true : false},
  "entryPoint": ${jsonencode(var.entry_point)},
  "command": ${jsonencode(var.command)},
  "environment": ${jsonencode(var.environment)},
  "links": ${jsonencode(var.links)},
  "privileged": ${var.privileged ? true : false},
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "${var.log_group_name}",
      "awslogs-stream-prefix": "${var.log_stream_prefix == "" ? var.name : var.log_stream_prefix}",
      "awslogs-region": "${data.aws_region.current.name}"
    }
  }
}
EOF
}