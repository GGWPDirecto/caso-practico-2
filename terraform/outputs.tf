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