include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/k8s_service_account///"
}

inputs = {
  service_account_name    = "loki-s3-access"
  cluster_namespace       = dependency.namespace.outputs.namespace
  cluster_name            = dependency.cluster.outputs.cluster_name
  cluster_endpoint        = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate  = dependency.cluster.outputs.cluster_ca_certificate
  annotations           = {
                            "eks.amazonaws.com/role-arn" = dependency.loki_s3_access_role.outputs.role_arn
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

dependency "loki_s3_access_role" {
  config_path = "../../../role/loki_s3"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    role_id = "role-id"
    role_arn = "role-arn"
    role_name = "role-name"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}



dependency "namespace" {
  config_path = "../../../eks/applications/monitoring/namespace"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    namespace = "monitoring"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}