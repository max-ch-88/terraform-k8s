output "rbac_access_all_role" {
  description = "The name of the RBAC role that grants admin level permissions on the namespace."
  value = element(
    concat(kubernetes_role.rbac_role_access_all.*.metadata.0.name, [""]),
    0,
  )
}
