include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/subnet///"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  igw_id = dependency.vpc.outputs.igw_id
  ipv4_cidr_block = dependency.vpc.outputs.vpc_cidr_block
  availability_zones = var.availability_zones
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