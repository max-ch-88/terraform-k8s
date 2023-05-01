output "name" {
  description = "The name of the created namespace."
  value       = element(concat(kubernetes_namespace.namespace.*.id, [""]), 0)
}

output "rbac_access_all_role" {
  description = "The name of the RBAC role that grants admin level permissions on the namespace."
  value       = module.namespace_roles.rbac_access_all_role
}
