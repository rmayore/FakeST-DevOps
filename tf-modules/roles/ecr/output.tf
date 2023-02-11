output "read_role_id" {
  value = module.ecr-read-role.id
}
output "read_role_arn" {
  value = module.ecr-read-role.arn
}
output "readwrite_role_id" {
  value = module.ecr-read-write-role.id
}
output "readwrite_role_arn" {
  value = module.ecr-read-write-role.arn
}