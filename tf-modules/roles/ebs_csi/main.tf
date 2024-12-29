
# EBS CSI IAM Role for Service Account
module "elb_ebs_csi_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${var.cluster_name}_ebs_csi_role"

  attach_ebs_csi_policy = var.attach_ebs_csi_policy

  oidc_providers = {
    main = {
      provider_arn               = var.cluster_oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-ebs-csi-driver"]
    }
  }
}