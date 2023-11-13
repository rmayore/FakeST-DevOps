output "key_name" {
  value = module.ssh_key_pair.key_name
}
output "public_key" {
  value = module.ssh_key_pair.public_key
}