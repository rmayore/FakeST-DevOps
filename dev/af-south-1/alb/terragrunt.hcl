include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/aws_alb///"
}

inputs = {
  vpc_id                        = dependency.vpc.outputs.vpc_id
  vpc_default_security_group_id = dependency.vpc.outputs.vpc_default_security_group_id
  public_subnet_ids             = dependency.subnet.outputs.public_subnet_ids
  alb_logs_bucket_id            = dependency.alb_logs_s3_bucket.outputs.bucket_id
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
    igw_id = "fake-igw-id"
    ipv4_cidr_block = "fake-ipv4-cidr-block"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "subnet" {
  config_path = "../subnet"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    private_subnet_ids = ["fake-private-subnet-id"]
    public_subnet_ids = ["fake-public-subnet-id"]
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "alb_logs_s3_bucket" {
  config_path = "../s3/alb_logs"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    bucket_id = "fake-bucket-id"
    bucket_arn = "fake-bucket-arn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}