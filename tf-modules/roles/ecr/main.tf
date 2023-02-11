
data "aws_iam_policy_document" "ecr_full_access" {
  statement {
    sid       = "ECRReadWriteAccess"
    effect    = "Allow"
    resources = ["arn:aws:ecr:${var.aws_region}::repository/*"]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy"
    ]
  }
}

data "aws_iam_policy_document" "ecr_read_access" {
  statement {
    sid       = "ECRReadAccess"
    effect    = "Allow"
    resources = ["arn:aws:ecr:${var.aws_region}::repository/*"]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings"
    ]
  }
}

module "ecr-read-write-role" {
  source    = "cloudposse/iam-role/aws"
  version   = "0.17.0"
  enabled   = true
  namespace = "fake-st"
  stage     = "dev"
  name      = "EcrReadWriteRole"

  policy_description = "Allow ECR Full Access"
  role_description   = "IAM role with permissions to perform actions on ECR resources"

  principals = {
    AWS = ["*"]
  }

  policy_documents = [
    data.aws_iam_policy_document.ecr_full_access.json,
    data.aws_iam_policy_document.ecr_read_access.json
  ]
}

module "ecr-read-role" {
  source    = "cloudposse/iam-role/aws"
  version   = "0.17.0"
  enabled   = true
  namespace = "fake-st"
  stage     = "dev"
  name      = "EcrReadRole"

  policy_description = "Allow ECR Read Access"
  role_description   = "IAM role with permissions to perform READ actions on ECR resources"

  principals = {
    AWS = ["*"]
  }

  policy_documents = [
    data.aws_iam_policy_document.ecr_read_access.json
  ]
}