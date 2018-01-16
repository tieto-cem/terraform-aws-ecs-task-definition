resource "aws_iam_role" "task_role" {
  name               = "${var.task_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "TrustTask",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "task_role_policy_attachments" {
  count      = "${length(var.task_role_policies)}"
  role       = "${aws_iam_role.task_role.id}"
  policy_arn = "${element(var.task_role_policies, count.index)}"
}

resource "aws_cloudwatch_log_group" "container_logs" {
  name = "${var.task_name}-task-logs"
}

data "aws_region" "current" {
  current = true
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.container_name}-task-definition"
  task_role_arn            = "${aws_iam_role.task_role.arn}"
  network_mode             = "${var.network_mode}"
  requires_compatibilities = ["EC2"]
  container_definitions    = <<EOF
[
  {
    "name": "${var.container_name}",
    "image": "${var.image}",
    ${var.memory_hard_limit == 0 ? "" : "\"memory\": ${var.memory_hard_limit},"}
    ${var.memory_soft_limit == 0 ? "" : "\"memoryReservation\": ${var.memory_soft_limit},"}
    "portMappings": ${replace(jsonencode(var.port_mappings), "/\"(?P<port>\\d+)\"/", "$port")},
    ${var.cpu == "" ? "" : "\"cpu\": ${var.cpu},"}
    "essential": ${var.essential ? true : false},
    "entryPoint": ${jsonencode(var.entryPoint)},
    "command": ${jsonencode(var.command)},
    "environment": ${jsonencode(var.environment)},
    "links": ${jsonencode(var.links)},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.container_logs.name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "${var.container_name}-container"
      }
    },
    "privileged": ${var.privileged ? true : false}
  }
]
EOF
}