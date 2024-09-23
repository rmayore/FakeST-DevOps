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


variable "private_subnet_ids" {
  type        = set(string)
  description = "Subnet IDs of private subnets"
}
variable "public_subnet_ids" {
  type        = set(string)
  description = "Subnet IDs of public subnets"
}
variable "private_route_table_ids" {
  type        = set(string)
  description = "Route tables of private subnets"
}
variable "public_route_table_ids" {
  type        = set(string)
  description = "Route tables of public subnets"
}

variable "ha_mode" {
  type        = bool
  default     = true
  description = "Enables high-availability mode"
}

variable "use_spot_instances" {
  type        = bool
  default     = true
  description = "Use spot instances?"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
}



