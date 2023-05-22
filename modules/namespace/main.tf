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

resource "kubernetes_namespace" "namespace" {
  count      = var.create_resources ? 1 : 0
  depends_on = [null_resource.dependency_getter]

  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}

resource "kubernetes_resource_quota" "limit_range" {
  metadata {
    name      = "quota"
    namespace = var.name
  }
  spec {
    hard = {
        "limits.cpu"    = var.limit_cpu
        "limits.memory" = var.limit_mem
    }
  }
}

module "namespace_roles" {
  source = "../namespace-roles"

  namespace   = var.create_resources ? kubernetes_namespace.namespace[0].id : ""
  labels      = var.labels
  annotations = var.annotations

  create_resources = var.create_resources
  dependencies     = var.dependencies
}
