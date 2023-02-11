include {
  path = find_in_parent_folders()
} 

terraform {
  source = "git::https://github.com/cloudposse/terraform-aws-ecr.git"
}

inputs = {
  version     = "v0.35.0"
  name                   = "test"
  principals_full_access = [dependency.roles.outputs.readwrite_role_arn]
  principals_readonly_access = [dependency.roles.outputs.read_role_arn]
}

dependency "roles" {
  config_path = "../../role/ecr"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    read_role_arn = "arn:aws:ecr:fake:fake:repository/*"
    readwrite_role_arn = "arn:aws:ecr:fake:fake:repository/*"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}