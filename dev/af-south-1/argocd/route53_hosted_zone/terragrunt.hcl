include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/route53_hosted_zone///"
}

inputs = {
  name = "argocd"
}