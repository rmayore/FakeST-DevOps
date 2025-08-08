output "role_id" {
  value = module.loki_s3_access_role.iam_role_unique_id
}
output "role_arn" {
  value = module.loki_s3_access_role.iam_role_arn
}
output "role_name" {
  value = module.loki_s3_access_role.iam_role_name
}