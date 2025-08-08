
# IAM Role for Service Account for Loki s3 bucket
module "loki_s3_access_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${var.cluster_name}_loki_s3_access"

  oidc_providers = {
    main = {
      provider_arn               = var.cluster_oidc_provider_arn
      namespace_service_accounts = ["monitoring:loki-s3-access"]
    }
  }
}