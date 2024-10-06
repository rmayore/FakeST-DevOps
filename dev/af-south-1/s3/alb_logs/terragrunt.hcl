include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/aws_s3_bucket///"
}

inputs = {
  bucket_name = "alb-logs"
}