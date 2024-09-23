include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/nat_instance///"
}

inputs = {
  vpc_id                      = dependency.vpc.outputs.vpc_id
  private_subnet_ids          = dependency.subnet.outputs.private_subnet_ids
  public_subnet_ids           = dependency.subnet.outputs.public_subnet_ids

  private_route_table_ids     = dependency.subnet.outputs.private_route_table_ids
  public_route_table_ids      = dependency.subnet.outputs.public_route_table_ids

  ha_mode                     = true
  use_spot_instances          = true
  instance_type               = "t3.micro"

}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    igw_id = "fake-igw-id"
    ipv4_cidr_block = "fake-ipv4-cidr-block"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "subnet" {
  config_path = "../subnet"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    private_subnet_ids = ["fake-private-subnet-id"]
    public_subnet_ids = ["fake-public-subnet-id"]
    private_route_table_ids = ["fake-private-route-table-ids"]
    public_route_table_ids = ["fake-public-route-table-ids"]
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}