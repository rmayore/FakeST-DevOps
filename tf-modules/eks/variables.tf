# Application
variable "app_name" {
  type        = string
  description = "App Name"
}
variable "namespace" {
  type        = string
  description = "Namespace"
}
variable "stage" {
  type        = string
  description = "Stage"
}

# Cluster
variable "cluster_name" {
  type        = string
  description = "Name Of Cluster"
}
variable "cluster_version" {
  type        = string
  description = "Version Of The Cluster"
}
variable "instance_types" {
  type        = set(string)
  description = "Set of instance types associated with the EKS worker Node Group."
}

variable "scaling_desired_size" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "scaling_max_size" {
  type        = number
  description = "Maximum number of worker nodes"
}

variable "scaling_min_size" {
  type        = number
  description = "Minimum number of worker nodes"
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "endpoint_private_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}


# Network
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "private_subnet_ids" {
  type        = set(string)
  description = "Private Subnet IDs"
}
variable "public_subnet_ids" {
  type        = set(string)
  description = "Public Subnet IDs"
}
variable "public_access_cidrs" {
  type        = set(string)
  description = "CIDR block range for vpc"
}

variable "sg_id" {
  type        = string
  description = "Cluster Security Group ID"
}


# Roles
variable "eks_cluster_role_arn" {
  type        = string
  description = "Master Cluster Role ARN"
}
variable "eks_node_group_role_arn" {
  type        = string
  description = "Node Group Cluster Role ARN"
}
