provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_service_account" "service_account" {
  metadata {
    name        = var.service_account_name
    namespace   = var.cluster_namespace
    annotations = var.annotations
  }
}