output "bucket_id" {
  value = aws_s3_bucket.loki.id
}
output "bucket_arn" {
  value = aws_s3_bucket.loki.arn
}
output "bucket_name" {
  value = var.bucket_name
}