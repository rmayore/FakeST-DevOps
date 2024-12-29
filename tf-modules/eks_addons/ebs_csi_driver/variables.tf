variable "cluster_name" {
  type        = string
  description = "Name Of Cluster"
}
variable "cluster_endpoint" {
  type        = string
  description = "Public endpoint Of Cluster"
}
variable "cluster_ca_certificate" {
  type        = string
  description = "CA Certificate Of The Cluster"
}



variable "addon_name" {
  type        = string
  description = "Name of EBS CSI Driver"
}
variable "addon_version" {
  type        = string
  description = "Version of EBS CSI Driver"
}

variable "service_account_role_arn" {
  type        = string
  description = "ARN Of EBS CSI driver role"
}