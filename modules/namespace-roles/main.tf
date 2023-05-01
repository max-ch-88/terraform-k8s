terraform {
  required_version = ">= 1.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}

resource "null_resource" "dependency_getter" {
  triggers = {
    instance = join(",", var.dependencies)
  }
}

resource "kubernetes_role" "rbac_role_access_all" {
  count      = var.create_resources ? 1 : 0
  depends_on = [null_resource.dependency_getter]

  metadata {
    name        = "${var.namespace}-access-all"
    namespace   = var.namespace
    labels      = var.labels
    annotations = var.annotations
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}
