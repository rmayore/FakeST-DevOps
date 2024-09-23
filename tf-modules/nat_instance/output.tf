output "instance_arns" {
  # If NOT running in HA mode
  value = values(module.nat_instance).*.instance_arn
}
output "instance_public_ips" {
  # The public IP address of the nat instance if running in non-HA mode
  value = values(module.nat_instance).*.instance_public_ip
}
output "autoscaling_group_arns" {
   # If running in HA mode
  value = values(module.nat_instance).*.autoscaling_group_arn
}