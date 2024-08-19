
module "vpc" {
  source    = "cloudposse/vpc/aws"
  version   = "2.1.0"
  enabled   = true
  namespace = var.namespace
  stage     = var.stage
  name      = "${var.app_name}-vpc"

  internet_gateway_enabled         = true
  ipv4_primary_cidr_block          = var.ipv4_primary_cidr_block
  assign_generated_ipv6_cidr_block = true
}