
module "subnet" {
  source    = "cloudposse/dynamic-subnets/aws"
  version   = "2.4.1"
  enabled   = true
  namespace = var.namespace
  stage     = var.stage
  name      = "${var.app_name}-subnet"

  vpc_id             = var.vpc_id
  igw_id             = [var.igw_id]
  ipv4_cidr_block    = [var.ipv4_cidr_block]
  availability_zones = var.availability_zones
}