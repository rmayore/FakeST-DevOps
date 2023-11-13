include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/a_record///"
}

inputs = {
  zone_id = dependency.hosted_zone.outputs.zone_id
  zone_name = dependency.hosted_zone.outputs.zone_name
  eip = dependency.ec2.outputs.ec2_public_ip
}

dependency "hosted_zone" {
  config_path = "../../route53_hosted_zone/test"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    zone_id = "fake-zone-id"
    zone_name = "fake-zone-name"
    parent_zone_id = "fake-parent-zone-id"
    parent_zone_name = "fake-parent-zone-name"
    fqdn = "fake-fqdn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}



dependency "ec2" {
  config_path = "../../ec2/test"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    ec2_id = "fake-ec2-id"
    ec2_arn = "fake-ec2-arn"
    ec2_public_ip = "fake-ec2-public-ip"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}