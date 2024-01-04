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

variable "instance_type" {
  type        = string
  description = "AWS Instance Type"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "subnet_id" {
  type        = string
  description = "Subnet Id"
}
variable "security_groups" {
  type        = set(string)
  description = "Security Groups"
}
variable "ssh_key_pair" {
  type        = string
  description = "SSH Key Pair Name"
}
variable "user_data" {
  type        = string
  default     = null
  description = "User-Data Base64 encoded binary"
}
