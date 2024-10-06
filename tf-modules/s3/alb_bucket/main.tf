resource "aws_s3_bucket" "logs" {
  bucket = "${var.app_name}-${var.bucket_name}-bucket"

  tags = {
    Name = "${var.app_name}-${var.bucket_name}-bucket"
    Environment = var.stage
  }
}

resource "aws_s3_bucket_policy" "lb_logs" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.lb_logs.json
}

data "aws_iam_policy_document" "lb_logs" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.lb.arn]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logs.arn}/*"]
  }
}

data "aws_elb_service_account" "lb" {}