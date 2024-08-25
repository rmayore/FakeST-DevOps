output "eks_cluster_role_id" {
  value = aws_iam_role.eks_cluster_role.id
}
output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}
output "eks_node_group_role_id" {
  value = aws_iam_role.eks_node_group_role.id
}
output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}