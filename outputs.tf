output "arn" {
  value = "${aws_ecs_task_definition.task_definition.arn}"
}

output "role_id" {
  value = "${aws_iam_role.task_role.id}"
}

output "container_definitions" {
  value = "${local.patched_json}"
}