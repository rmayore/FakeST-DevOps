include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/ec2///"
}

inputs = {
  instance_type               = "t3.small"
  vpc_id                      = dependency.vpc.outputs.vpc_id
  security_groups             = [dependency.security_group.outputs.sg_id]
  subnet_id                   = dependency.subnet.outputs.public_subnet_ids[0]
  ssh_key_pair                = dependency.key_pair.outputs.key_name
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    igw_id = "fake-igw-id"
    ipv4_cidr_block = "fake-ipv4-cidr-block"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

# subnet is a dependenct of vpc, making vpc a 'grand-dependency', all that will be sorted though by the dependency graph
dependency "subnet" {
  config_path = "../../subnet"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    private_subnet_ids = ["fake-private-subnet-id"]
    public_subnet_ids = ["fake-public-subnet-id"]
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "security_group" {
  config_path = "../security_group"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    sg_id = "fake-sg-id"
    sg_arn = "fake-sg-arn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "key_pair" {
  config_path = "../key_pair"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    key_name = "fake-key-name"
    public_key = "fake-public-key"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}