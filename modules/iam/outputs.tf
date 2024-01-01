output "iam_roles_arn" {
  value = {
    ecs_task_role     = aws_iam_role.ecs_task_role.arn
    codepipeline_role = aws_iam_role.codepipeline_role.arn
  }
}
output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
