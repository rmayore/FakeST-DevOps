# Create EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.eks_cluster_role_arn

  vpc_config { # Configure EKS with vpc and network settings 
    subnet_ids              = flatten([var.public_subnet_ids[*], var.private_subnet_ids[*]])
    security_group_ids      = ["${var.sg_id}"]
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    # public_access_cidrs     = var.public_access_cidrs 
    # Above fails with error InvalidParameterException: The following CIDRs are not allowed in publicAccessCidrs: [10.1.0.128/27, 10.1.0.96/27]
  }

  tags = {
    namespace = var.namespace
    stage     = var.stage
  }
}

# Create EKS Node Groups
resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.eks_node_group_role_arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = var.instance_types

  scaling_config {
    desired_size = var.scaling_desired_size
    max_size     = var.scaling_max_size
    min_size     = var.scaling_min_size
  }

  tags = {
    name      = "${var.cluster_name}-node-group"
    namespace = var.namespace
    stage     = var.stage
  }
}