
locals {
  mapping_list = zipmap(tolist(var.public_subnet_ids), tolist(var.private_route_table_ids))
}


module "nat_instance" {
  for_each              = local.mapping_list #Create one per AZ (1 private & 1 public subnet in each AZ)
  source                = "RaJiska/fck-nat/aws"
  version               = "1.3.0"

  name                  = "${var.app_name}-nat-gw-${each.key}"

  instance_type         = var.instance_type
  vpc_id                = var.vpc_id
  subnet_id             = each.key
  ha_mode               = var.ha_mode
  use_spot_instances    = var.use_spot_instances
  update_route_table    = true
  route_table_id        = each.value
  use_cloudwatch_agent  = true  

  tags = {
    Terraform = true
    namespace = var.namespace
    stage = var.stage
  }
}



