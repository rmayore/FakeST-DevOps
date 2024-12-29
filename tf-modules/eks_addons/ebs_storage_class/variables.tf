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
variable "type" {
  type        = string
  description = "Storage type e.g. GP3"
}
variable "encrypted" {
  type        = bool
  default     = true
  description = "CA Certificate Of The Cluster"
}
variable "name" {
  type        = string
  description = "Name Of Storage Class"
}