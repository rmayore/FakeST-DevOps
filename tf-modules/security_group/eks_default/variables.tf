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

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS Cluster"
}