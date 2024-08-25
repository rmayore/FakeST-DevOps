
# CLUSTER IAM ROLE
data "aws_iam_policy_document" "eks_cluster_role_policy_document" {
  statement {
    sid    = "EKSClusterRolePolicyDocument"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

# Create IAM role for Kubernetes clusters to make calls to 
# other AWS services on your behalf to manage the resources
# that you use with the service
resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.cluster_name}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_role_policy_document.json
}


#  Attach the EKS-Cluster policies to the master_cluster_role role
resource "aws_iam_role_policy_attachment" "eks_cluster_role_attachment-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

#  Attach the EKS-Service policies to the master_cluster_role role
resource "aws_iam_role_policy_attachment" "eks_cluster_role_attachment-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# NODE GROUP IAM ROLE 
data "aws_iam_policy_document" "eks_node_group_policy_document" {
  statement {
    sid    = "EKSNodesGroupRolePolicyDocument"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

# Create IAM role for EKS nodes group to work with other AWS Services
resource "aws_iam_role" "eks_node_group_role" {
  name               = "${var.cluster_name}-eks-node-group-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_group_policy_document.json
  force_detach_policies = true
}


#  Attach the AmazonEKSWorkerNodePolicy policies to the eks_node_group_role role
resource "aws_iam_role_policy_attachment" "eks_node_group_role_attachment-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

#  Attach the AmazonEKS_CNI_Policy policies to the eks_node_group_role role
resource "aws_iam_role_policy_attachment" "eks_node_group_role_attachment-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

#  Attach the AmazonEC2ContainerRegistryReadOnly policies to the eks_node_group_role role
resource "aws_iam_role_policy_attachment" "eks_node_group_role_attachment-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}