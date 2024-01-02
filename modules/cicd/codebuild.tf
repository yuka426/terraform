resource "aws_codebuild_project" "terraform_codebuild_project" {

  count = length(local.build_projects)

  name         = "terraform-${local.build_projects[count.index]}"
  service_role = var.iam_roles_arn.codepipeline_role
  tags = {
    Name = "codebuild-${local.build_projects[count.index]}"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type         = "LINUX_CONTAINER"
  }
  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = "terraform-codepipeline"
      stream_name = "codepipeline"
    }
    s3_logs {
      status = "DISABLED"
    }
  }
  source {
    type = "CODEPIPELINE"
    # location        = "https://github.com/yuka426/terraform.git"
    # git_clone_depth = 1
    buildspec = "./templates/buildspec_${local.build_projects[count.index]}.yml"
  }
}
