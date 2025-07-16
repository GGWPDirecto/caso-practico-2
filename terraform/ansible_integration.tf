# terraform/ansible_integration.tf
# Este fichero se encarga de generar la configuración para Ansible.

resource "local_file" "ansible_inventory" {
  # Contenido del fichero que se va a crear.
  # La función 'templatefile' lee la plantilla y reemplaza las variables.
  content = templatefile("../ansible/inventory.tmpl", {
    vm_ip            = azurerm_public_ip.pip_vm.ip_address
    ssh_user         = var.ssh_user
    acr_login_server = azurerm_container_registry.acr.login_server
    acr_username     = azurerm_container_registry.acr.admin_username
    acr_password     = azurerm_container_registry.acr.admin_password
  })

  # Ruta y nombre del fichero que se creará.
  filename = "../ansible/hosts"
}

# También generamos el fichero con la clave privada.
resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "../ansible/private_key.pem"
  # Permisos de fichero para Linux/macOS (equivalente a chmod 400).
  file_permission = "0400"
}