# Fichero para definir los valores de salida de la infraestructura.

output "vm_public_ip" {
  description = "IP pública de la VM para conexión SSH y acceso a la aplicación."
  value       = azurerm_public_ip.pip_vm.ip_address
}

output "acr_login_server" {
  description = "URL del servidor de login de ACR para el push/pull de imágenes."
  value       = azurerm_container_registry.acr.login_server
}

output "ssh_private_key_pem" {
  description = "Clave privada SSH para acceder a la VM. Guardar en un lugar seguro."
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

output "aks_kube_config" {
  description = "Fichero kubeconfig para conectar al clúster de AKS con kubectl."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "acr_admin_username" {
  description = "Usuario admin del ACR."
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "Password admin del ACR."
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}