include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/eks_addons/ebs_storage_class///"
}

inputs = {
  name                    = "auto-ebs-sc"
  type                    = "gp3"
  encrypted               = true
  cluster_name            = dependency.cluster.outputs.cluster_name
  cluster_endpoint        = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate  = dependency.cluster.outputs.cluster_ca_certificate
}

dependency "cluster" {
  config_path = "../../cluster"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    cluster_name = "fake-cluster-name"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_ca_certificate = "fake-base64-ca-certificate"
    cluster_oidc_provider_arn = "fake-oidc-provider-arn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}