variable "cluster_name" {
  type        = string
  description = "Name Of Cluster"
}
variable "cluster_endpoint" {
  type        = string
  description = "Pliblic endpoint Of Cluster"
}
variable "cluster_ca_certificate" {
  type        = string
  description = "CA Certificate Of The Cluster"
}

variable "email" {
  type        = string
  description = "Name Of The Cluster Issuer Email"
}
variable "cluster_issuer_name" {
  type        = string
  description = "Name Of The Cluster Issuer Name"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}
variable "parent_zone" {
  type        = string
  description = "Parent DNS Zone"
}