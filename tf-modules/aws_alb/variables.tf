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

variable "internal" {
  type        = bool
  description = "Whether ALB is internal"
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "ID of Virtual Private Cloud"
}

variable "vpc_default_security_group_id" {
  type        = string
  description = "ID of VPC's Default SG"
}

variable "public_subnet_ids" {
  type        = set(string)
  description = "Public Subnet IDs to attach to the LB"
}

variable "alb_logs_bucket_id" {
  type        = string
  description = "ID of S3 Bucket To Store Logs"
}