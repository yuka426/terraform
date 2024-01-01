resource "aws_codestarconnections_connection" "github" {
  name          = "emptio-github-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "terraform_pipeline" {

  name     = "terraform-pipeline"
  role_arn = var.iam_roles_arn.codepipeline_role
  tags = {
    Name = "terraform-pipeline"
  }

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      version          = "1"
      provider         = "CodeStarSourceConnection"
      output_artifacts = ["SourceOutput"]
      run_order        = 1

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "yuka426/terraform"
        BranchName       = "main"
      }
    }
  }

  dynamic "stage" {
    for_each = local.stage_input

    content {
      name = "Stage-${stage.value["name"]}"
      action {
        category         = stage.value["category"]
        name             = "Action-${stage.value["name"]}"
        owner            = stage.value["owner"]
        provider         = stage.value["provider"]
        input_artifacts  = [stage.value["input_artifacts"]]
        output_artifacts = [stage.value["output_artifacts"]]
        version          = "1"
        run_order        = index(local.build_projects, stage.value["name"]) + 2

        configuration = {
          ProjectName = stage.value["provider"] == "CodeBuild" ? "terraform-${stage.value["name"]}" : null
        }
      }
    }
  }

}