provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

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

module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"
  version       = "2.6.4"

  create_namespace                       = true

  cluster_issuer_email                   = var.email
  cluster_issuer_name                    = var.cluster_issuer_name
  cluster_issuer_private_key_secret_name = "${var.cluster_issuer_name}-private-key"

  solvers = [
    {
      dns01 = {
        route53 = {
          region  = var.aws_region
          ambient = "true"
        }
      },
      selector = {
        dnsZones = [
          var.parent_zone
        ]
      }
    },
    {
      http01 = {
        ingress = {
          class = "nginx"
        }
      }
    }
  ]
}