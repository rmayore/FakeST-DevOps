provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}


resource "helm_release" "kubernetes_dashboard" {
  name       = var.chart_name
  version    = var.chart_version
  repository = "https://kubernetes.github.io/dashboard"
  chart      = "kubernetes-dashboard"
  create_namespace = true
  namespace  = "kubernetes-dashboard"
}