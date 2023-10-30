module "ssh_key_pair" {
  source = "cloudposse/key-pair/aws"
  version   = "0.20.0"
  enabled   = true
  namespace = var.namespace
  stage     = var.stage
  name      = "${var.app_name}-aws-key-pair"

  ssh_public_key_path   = var.ssh_public_key_path
  ssh_public_key_file   = var.ssh_public_key_file
  generate_ssh_key      = false
  public_key_extension  = ".pub"
}