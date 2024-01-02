locals {
  stage_input = [
    { name = "validate", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "ValidateOutput" },
    { name = "plan", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "ValidateOutput", output_artifacts = "PlanOutput" },
    { name = "approval", category = "Approval", owner = "AWS", provider = "Manual", input_artifacts = "", output_artifacts = "" },
    { name = "apply", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "PlanOutput", output_artifacts = "ApplyOutput" }
  ]
  build_projects = ["validate", "plan", "approval", "apply"]
}
