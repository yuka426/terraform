resource "aws_iam_role" "codepipeline_role" {
  name               = "codepipeline_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
  path               = "/"
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "codepipeline-policy"
  description = "Policy to allow codepipeline to execute"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": "${var.codepipeline_bucket.arn}/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
        "codebuild:BatchGetProjects"
      ],
      "Resource": "arn:aws:codebuild:${var.aws.region}:${data.aws_caller_identity.current.account_id}:project/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases"
      ],
      "Resource": "arn:aws:codebuild:${var.aws.region}:${data.aws_caller_identity.current.account_id}:report-group/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:${var.aws.region}:${data.aws_caller_identity.current.account_id}:log-group:*"
    },
    {
        "Effect": "Allow",
        "Action": "codestar-connections:*",
        "Resource": "arn:aws:codestar-connections:*:${data.aws_caller_identity.current.account_id}:connection/*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "ssm:GetParameters",
            "ssm:GetParameter"
        ],
        "Resource": "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}