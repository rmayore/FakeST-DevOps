variable "cluster_name" {
  type        = string
  description = "Name Of Cluster"
}

variable "cluster_oidc_provider_arn" {
  type        = string
  description = "CLuster OIDC Provider"
}

variable "attach_ebs_csi_policy" {
  type        = bool
  default     = true
  description = "Attach EBS CSI Policy to this Service Account"
}
