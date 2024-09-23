output "elb_controller_role_id" {
  value = module.elb_controller_irsa_role.iam_role_unique_id
}
output "elb_controller_role_arn" {
  value = module.elb_controller_irsa_role.iam_role_arn
}
output "elb_controller_role_name" {
  value = module.elb_controller_irsa_role.iam_role_name
}