output "arn" {
  value = "${aws_ecs_task_definition.task_definition.arn}"
}

output "family" {
  value = "${aws_ecs_task_definition.task_definition.family}"
}

output "revision" {
  value = "${aws_ecs_task_definition.task_definition.revision}"
}

output "role_id" {
  value = "${aws_iam_role.task_role.id}"
}

output "container_definitions" {
  value = "${local.patched_json}"
}