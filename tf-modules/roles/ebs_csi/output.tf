output "role_id" {
  value = module.elb_ebs_csi_role.iam_role_unique_id
}
output "role_arn" {
  value = module.elb_ebs_csi_role.iam_role_arn
}
output "role_name" {
  value = module.elb_ebs_csi_role.iam_role_name
}