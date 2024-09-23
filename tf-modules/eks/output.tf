output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "CA Certificate Data for Cluster (Base64 encoded)"
  value       = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}

output "cluster_oidc_provider_arn" {
  description = "Cluster OIDC ARN"
  value       = aws_iam_openid_connect_provider.provider.arn
}