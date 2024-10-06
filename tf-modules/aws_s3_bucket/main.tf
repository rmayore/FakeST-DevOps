resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.app_name}-${var.bucket_name}-bucket"

  tags = {
    Name = "${var.app_name}-${var.bucket_name}-bucket"
    Environment = var.stage
  }
}