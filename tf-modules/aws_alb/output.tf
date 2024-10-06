output "alb_name" {
  value = module.alb.alb_name
}
output "alb_arn" {
  value = module.alb.alb_arn
}
output "alb_default_target_group_arn" {
  value = module.alb.default_target_group_arn
}
output "alb_security_group_id" {
  value = module.alb.security_group_id
}