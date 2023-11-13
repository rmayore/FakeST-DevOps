module "domain" {
  source = "cloudposse/route53-cluster-zone/aws"
  version   = "0.16.0"
  enabled   = true
  namespace = var.namespace
  stage     = var.stage
  name      = var.name

  parent_zone_name     = var.parent_zone
  zone_name            = "$${name}.$${stage}.$${parent_zone_name}"
}
