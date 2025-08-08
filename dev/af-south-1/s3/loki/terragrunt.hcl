include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/s3/loki_bucket///"
}

inputs = {
  bucket_name = "eks-loki"
  sa_role_arn = dependency.loki_s3_role.outputs.role_arn
}


dependency "loki_s3_role" {
  config_path = "../../role/loki_s3"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    role_id = "role-id"
    role_arn = "role-arn"
    role_name = "role-name"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}