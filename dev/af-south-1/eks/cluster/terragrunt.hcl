include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/eks///"
}

inputs = {
  cluster_name            = "fake-st-eks" # var.cluster_name
  cluster_version         = "1.30"
  instance_types          = ["t3.medium"]
  scaling_desired_size    = 2
  scaling_max_size        = 2
  scaling_min_size        = 1

  vpc_id                  = dependency.vpc.outputs.vpc_id
  private_subnet_ids      = dependency.subnet.outputs.public_subnet_ids
  public_subnet_ids       = dependency.subnet.outputs.private_subnet_ids
  sg_id                   = dependency.security_group.outputs.sg_id
  public_access_cidrs     = dependency.subnet.outputs.public_subnet_cidrs

  eks_cluster_role_arn    = dependency.roles.outputs.eks_cluster_role_arn
  eks_node_group_role_arn = dependency.roles.outputs.eks_node_group_role_arn
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
    private_route_table_ids = ["fake-private-rt-id"]
    public_route_table_ids = ["fake-public-rt-id"]
    public_subnet_cidrs = ["10.1.0.0/24"]
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "security_group" {
  config_path = "../security_group"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    sg_id = "fake-sg-id"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}


dependency "roles" {
  config_path = "../../role/eks"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    eks_cluster_role_id = "fake-id"
    eks_cluster_role_arn = "arn:aws:iam::fake:role/fake-st-eks-eks-cluster-role"
    eks_node_group_role_id = "fake-id"
    eks_node_group_role_arn = "arn:aws:iam::fake:role/fake-st-eks-eks-node-group-role"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}