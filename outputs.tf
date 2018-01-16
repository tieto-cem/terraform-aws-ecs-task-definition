
output "task_definition_arn" {
  value = "${aws_ecs_task_definition.task_definition.arn}"
}

output "task_role_id" {
  value = "${aws_iam_role.task_role.id}"
}