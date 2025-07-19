resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-casopractico2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic.id]
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
# Recurso del proveedor TLS para generar un par de claves SSH (privada/pública).
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Define la máquina virtual Linux donde se desplegará la aplicación con Podman.
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-podman"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B1s"
  admin_username        = var.ssh_user

  network_interface_ids = [azurerm_network_interface.nic_vm.id]

  # Configuración de la clave SSH usando la clave pública generada por el recurso tls_private_key.
  admin_ssh_key {
    username   = var.ssh_user
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}