include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/helm/prometheus///"
}

inputs = {
  cluster_name           = dependency.cluster.outputs.cluster_name
  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
  chart_name             = "prometheus"
  chart_version          = "26.0.1"
  k8s_namespace          = dependency.namespace.outputs.namespace
}



dependency "cluster" {
  config_path = "../../../cluster"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    cluster_name = "fake-cluster-name"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_ca_certificate = "fake-base64-ca-certificate"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}


dependency "namespace" {
  config_path = "../namespace"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    namespace = "monitoring"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}
