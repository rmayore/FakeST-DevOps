variable "service_account_name" {
  type        = string
  description = "Service Account Name"
}
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

variable "cluster_namespace" {
  type        = string
  description = "Namespace where this SA will be created"
}
variable "annotations" {
  type        = map(string)
  description = "Annotations fot the SA name (includes the roles the SA should assume)"
}