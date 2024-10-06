include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/s3/alb_bucket///"
}

inputs = {
  bucket_name = "alb-logs"
}