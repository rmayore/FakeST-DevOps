include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/eks_addons/ebs_csi_driver///"
}

inputs = {
  addon_name                = "aws-ebs-csi-driver"
  addon_version             = "v1.37.0-eksbuild.1"
  service_account_role_arn  = dependency.ebs_csi_role.outputs.role_arn
  cluster_name              = dependency.cluster.outputs.cluster_name
  cluster_endpoint          = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate    = dependency.cluster.outputs.cluster_ca_certificate
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



dependency "ebs_csi_role" {
  config_path = "../../../role/ebs_csi"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    role_id = "role-id"
    role_arn = "role-arn"
    role_name = "role-name"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}