output "role_name" {
  value = module.elb_controller_irsa_role.iam_role_name
}
output "role_id" {
  value = module.elb_controller_irsa_role.iam_role_unique_id
}
output "role_arn" {
  value = module.elb_controller_irsa_role.iam_role_arn
}