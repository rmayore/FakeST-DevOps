provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

resource "aws_eks_addon" "aws_ebs_csi_driver" {

  cluster_name  = var.cluster_name
  addon_name    = var.addon_name
  addon_version = var.addon_version

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  service_account_role_arn = var.service_account_role_arn

  configuration_values = jsonencode({
    controller = {
      tolerations : [
        {
          key : "system",
          operator : "Equal",
          value : "owned",
          effect : "NoSchedule"
        }
      ]
    }
  })

  preserve = true

  tags = {
    "eks_addon" = "aws-ebs-csi-driver"
  }
}