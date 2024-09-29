include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/k8s_service_account///"
}

inputs = {
  service_account_name    = "aws-load-balancer-controller"
  cluster_namespace       = "kube-system"
  cluster_name            = dependency.cluster.outputs.cluster_name
  cluster_endpoint        = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate  = dependency.cluster.outputs.cluster_ca_certificate
  annotations           = {
                            "eks.amazonaws.com/role-arn" = dependency.elb_controller_role.outputs.elb_controller_role_arn
                          }
}

dependency "cluster" {
  config_path = "../../../eks/cluster"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    cluster_name = "fake-cluster-name"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_ca_certificate = "fake-base64-ca-certificate"
    cluster_oidc_provider_arn = "fake-oidc-provider-arn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "elb_controller_role" {
  config_path = "../../../role/elb_controller"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    elb_controller_role_id = "fake-elb-controller-role-id"
    elb_controller_role_arn = "fake-elb-controller-role-arn"
    elb_controller_role_name = "fake-elb-controller-role-name"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}
