provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_manifest" "gp3-storage-class" {
  manifest = {
    "apiVersion" = "storage.k8s.io/v1"
    "kind"       = "StorageClass"
    "metadata" = {
      "name"      = var.name
      "annotations" = {
        "storageclass.kubernetes.io/is-default-class" = "true"
      }
    }
    "provisioner" = "ebs.csi.eks.amazonaws.com"
    "volumeBindingMode" = "WaitForFirstConsumer"
    "parameters" = {
      "type" = var.type
      "encrypted" = var.encrypted

    }
  }
}