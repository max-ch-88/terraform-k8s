terraform {
  required_version = ">= 1.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubectl_config_path
}

module "namespace" {
  source    = "./modules/namespace"
  name      = var.name
  limit_cpu = var.limit_cpu
  limit_mem = var.limit_mem
}

module "service_account_access_all" {
  source         = "./modules/service-account"
  name           = "${var.name}-admin"
  namespace      = module.namespace.name
  num_rbac_roles = 1

  rbac_roles = [
    {
      name      = module.namespace.rbac_access_all_role
      namespace = module.namespace.name
    },
  ]

  labels = {
    role = "admin"
  }
}
