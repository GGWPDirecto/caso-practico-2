


# Crea la máquina virtual Linux donde se desplegará la aplicación con Podman
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-casopractico2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s" # Tipo de instancia
  admin_username      = "azureuser"    # Usuario administrador
  network_interface_ids = [azurerm_network_interface.nic_vm.id] # NIC asociada

  # Configuración de la clave SSH usando la clave pública generada
  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-casopractico2"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}