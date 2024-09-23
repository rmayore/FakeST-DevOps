include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/helm/load_balancer_controller///"
}

inputs = {
  vpc_id                  = dependency.vpc.outputs.vpc_id
  cluster_name            = dependency.cluster.outputs.cluster_name
  cluster_endpoint        = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate  = dependency.cluster.outputs.cluster_ca_certificate
  chart_name              = "load-balancer-controller"
  chart_version           = "1.8.2"
  elb_controller_role_arn = dependency.roles.outputs.elb_controller_role_arn
}



dependency "cluster" {
  config_path = "../../cluster"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    cluster_name = "fake-cluster-name"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_ca_certificate = "fake-base64-ca-certificate"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "roles" {
  config_path = "../../../role/elb_controller"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    elb_controller_role_id = "fake-elb-controller-role-id"
    elb_controller_role_arn = "fake-elb-controller-role-arn"
    elb_controller_role_name = "fake-elb-controller-role-name"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}



dependency "vpc" {
  config_path = "../../../vpc"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    igw_id = "fake-igw-id"
    ipv4_cidr_block = "fake-ipv4-cidr-block"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}
