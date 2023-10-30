
module "ec2" {
  source = "cloudposse/ec2-instance/aws"
  version   = "1.1.0"
  enabled   = true
  namespace = var.namespace
  stage     = var.stage
  name      = "${var.app_name}-ec2"

  instance_type = var.instance_type


  ssh_key_pair                = var.ssh_key_pair
  vpc_id                      = var.vpc_id
  security_groups             = var.security_groups
  subnet                      = var.subnet_id
  associate_public_ip_address = true  # will create and assign EIP
}