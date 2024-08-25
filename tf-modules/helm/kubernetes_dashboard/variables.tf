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
variable "chart_name" {
  type        = string
  description = "Name Of The Chart Installation"
}
variable "chart_version" {
  type        = string
  description = "Version Of The Helm Chart To Install"
}