output "certificates" {
  description = "Issued Certificates"
  value       =  module.cert_manager.certificates
}

output "cluster_issuer_name" {
  description = "Cluster Issuer Name"
  value       = module.cert_manager.cluster_issuer_name
}