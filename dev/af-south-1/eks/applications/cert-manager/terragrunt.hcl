include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/helm/cert_manager///"
}

inputs = {
  cluster_name           = dependency.cluster.outputs.cluster_name
  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
  cluster_issuer_name    = "cert-manager-cluster-issuer"
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
