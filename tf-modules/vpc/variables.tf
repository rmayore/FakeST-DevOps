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
variable "ipv4_primary_cidr_block" {
  type        = string
  description = "CIDR Block For VPC"
}
