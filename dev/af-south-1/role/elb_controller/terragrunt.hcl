include {
  path = find_in_parent_folders()
}

# This module also creates an ELB IRSA
terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/roles/load_balancer_controller///"
}

inputs = {
  cluster_name                        = dependency.cluster.outputs.cluster_name
  cluster_oidc_provider_arn           = dependency.cluster.outputs.cluster_oidc_provider_arn
}


dependency "cluster" {
  config_path = "../../eks/cluster"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    cluster_name = "fake-cluster-name"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_ca_certificate = "fake-base64-ca-certificate"
    cluster_oidc_provider_arn = "fake-oidc-provider-arn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}