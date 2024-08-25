output "private_subnet_ids" {
  value = module.subnet.private_subnet_ids
}
output "public_subnet_ids" {
  value = module.subnet.public_subnet_ids
}
output "private_route_table_ids" {
  value = module.subnet.private_route_table_ids
}
output "public_route_table_ids" {
  value = module.subnet.public_route_table_ids
}
output "public_subnet_cidrs" {
  value = module.subnet.public_subnet_cidrs
}