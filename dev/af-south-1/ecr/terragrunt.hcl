# Automatically find the root terragrunt.hcl and inherit its onfiguration
include {
  path = find_in_parent_folders()
} 

dependency "roles" {
  # Path to module
  config_path = "../role/ecr"
  # Configure mock outputs for the `validate` command that are returned when there are no outputs available
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    read_role_arn = "arn:aws:ecr:fake:fake:repository/*"
    readwrite_role_arn = "arn:aws:ecr:fake:fake:repository/*"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  source = "cloudposse/ecr/aws"
  version     = "0.35.0"
  namespace              = "fake-st"
  stage                  = "dev"
  name                   = "test"
  principals_full_access = [dependency.roles.outputs.readwrite_role_arn]
  principals_readonly_access = [dependency.roles.outputs.read_role_arn]
}