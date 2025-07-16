# terraform/ansible_integration.tf

resource "local_file" "ansible_inventory" {
  content = templatefile("../ansible/inventory.yml.tmpl", {
    vm_ip            = azurerm_public_ip.pip_vm.ip_address
    ssh_user         = var.ssh_user
    acr_login_server = azurerm_container_registry.acr.login_server
    acr_username     = azurerm_container_registry.acr.admin_username
    key_vault_url    = azurerm_key_vault.kv.vault_uri
  })
  filename = "../ansible/hosts.yml"
}

# El recurso para la clave SSH .
resource "local_file" "ssh_private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "../ansible/private_key.pem"
  file_permission = "0400"
}