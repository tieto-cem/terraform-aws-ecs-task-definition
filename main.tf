
#---------------------------------------
#  Role for the task definition - policies passed using var.role_policies are attached to this role
#---------------------------------------

resource "aws_iam_role" "task_role" {
  name               = "${var.name}-task-role"
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
  count      = "${length(var.role_policies)}"
  role       = "${aws_iam_role.task_role.id}"
  policy_arn = "${element(var.role_policies, count.index)}"
}

#----------------------
# CloudWatch Log Group for storing task's container logs
#-------------------------

resource "aws_cloudwatch_log_group" "task_log_group" {
  name = "/ecs/task/${var.name}"
}

#----------------------
# Task Definition
#----------------------

# value of awslogs-group attribute is replaced with the log group name created in this module

locals {
  container_defs_json = "[${join(",", var.container_definitions)}]"
  log_group_matcher = "/\"awslogs-group\":\\s*\"[^\"\\n\\r]*\"/"
  match_replacement = "\"awslogs-group\": \"${aws_cloudwatch_log_group.task_log_group.name}\""
  patched_json = "${replace(local.container_defs_json, local.log_group_matcher, local.match_replacement)}"
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.name}"
  task_role_arn            = "${aws_iam_role.task_role.arn}"
  network_mode             = "${var.network_mode}"
  requires_compatibilities = ["EC2"]
  container_definitions    = "${local.patched_json}"
}