
module "ec2-default-security-group" {
  source    = "cloudposse/security-group/aws"
  version   = "2.2.0"
  enabled   = true
  namespace = var.namespace
  stage     = var.stage
  name      = "${var.app_name}-ec2-default-sg"

  vpc_id = var.vpc_id

  attributes                 = ["ec2-default"]
  allow_all_egress           = true # Allow unlimited egress
  create_before_destroy      = true
  preserve_security_group_id = false

  rules = [
    {
      key         = "SSH"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null # preferable to self = false
      description = "Allow SSH from anywhere"
    },
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = []
      self        = true
      description = "Allow HTTP from inside the security group"
    },
    {
      key         = "HTTPS"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = []
      self        = true
      description = "Allow HTTPS from inside the security group"
    }
  ]
}