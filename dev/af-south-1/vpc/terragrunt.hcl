include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/vpc///"
}


inputs = {
  ipv4_primary_cidr_block   = "10.1.0.0/24"
}