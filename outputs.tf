output "name" {
  description = "Name of the created namespace"
  value       = module.namespace.name
}

output "rbac_access_all_role" {
  description = "The name of the RBAC role that grants admin level permissions on the namespace."
  value       = module.namespace.rbac_access_all_role
}

output "service_account_access_all" {
  description = "The name of the ServiceAccount that has admin level permissions."
  value       = module.service_account_access_all.name
}
