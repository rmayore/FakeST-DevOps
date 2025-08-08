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


resource "helm_release" "grafana" {
  name            = var.chart_name
  version         = var.chart_version
  repository      = "https://grafana.github.io/helm-charts"
  chart           = "grafana"
  namespace       = var.k8s_namespace
  cleanup_on_fail = true
  timeout         = 1500
}