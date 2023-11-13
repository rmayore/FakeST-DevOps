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
variable "igw_id" {
  type        = string
  description = "Internet Gateway Id"
}
variable "ipv4_cidr_block" {
  type        = string
  description = "IPv4 CIDR Block"
}
variable "availability_zones" {
  type        = set(string)
  description = "AWS Availability Zones For Region"
}
