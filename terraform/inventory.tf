# Genera el inventario de Ansible dinámicamente usando la IP pública de la VM
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl", {
    vm_public_ip     = azurerm_public_ip.vm_pip.ip_address
    acr_name         = azurerm_container_registry.acr.name
    acr_login_server  = azurerm_container_registry.acr.login_server
    acr_username      = azurerm_container_registry.acr.admin_username
    ssh_user         = var.ssh_user
    ssh_key_path     = var.ssh_key_path
  })
  filename = "../ansible/hosts"
}
