module "alb" {
  source  = "cloudposse/alb/aws"
  version = "1.11.1"

  namespace  = var.namespace
  stage      = var.stage
  name       = "${var.app_name}-alb"

  vpc_id                                  = var.vpc_id
  security_group_ids                      = [var.vpc_default_security_group_id]
  subnet_ids                              = var.public_subnet_ids
  internal                                = var.internal
  http_enabled                            = true
  http_redirect                           = true
  access_logs_enabled                     = true
  access_logs_s3_bucket_id                = var.alb_logs_bucket_id

  target_group_name                       = "${var.app_name}-alb-default-tg"

  tags = {
    Name = "${var.app_name}-alb"
    Namespace = var.namespace
    Environment = var.stage
  }
}