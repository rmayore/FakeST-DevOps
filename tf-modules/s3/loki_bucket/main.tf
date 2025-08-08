resource "aws_s3_bucket" "loki" {
  bucket = "${var.app_name}-${var.bucket_name}-bucket"

  tags = {
    Name = "${var.app_name}-${var.bucket_name}-bucket"
    Environment = var.stage
  }
}

resource "aws_s3_bucket_policy" "loki" {
  bucket = aws_s3_bucket.loki.id
  policy = data.aws_iam_policy_document.loki.json
}

data "aws_iam_policy_document" "loki" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.sa_role_arn]
    }
    actions   = ["s3:PutObject","s3:GetObject","s3:DeleteObject"]
    resources = ["${aws_s3_bucket.loki.arn}/*"]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.sa_role_arn]
    }
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.loki.arn}"]
  }
}