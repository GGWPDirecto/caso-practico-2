# Genera el inventario de Ansible dinámicamente usando la IP pública de la VM
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/inventory.tmpl", {
    vm_public_ip     = azurerm_public_ip.pip_vm.ip_address
    ssh_user         = var.ssh_user
    acr_login_server = azurerm_container_registry.acr.login_server
    acr_username     = azurerm_container_registry.acr.admin_username
    acr_password     = azurerm_container_registry.acr.admin_password
  })
  filename = "${path.module}/../ansible/hosts.yml"
}
