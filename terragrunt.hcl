remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "fake-st-terraform-state"
    key     = "${path_relative_to_include()}.tfstate"
    region  = "af-south-1"
    encrypt = true
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    optional_var_files = [
      find_in_parent_folders("regional.tfvars"),
      find_in_parent_folders("global_variables.tfvars"),
    ]
  }
}