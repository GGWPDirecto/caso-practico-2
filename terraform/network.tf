
# Crea la red virtual principal del proyecto
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-casopractico2"           # Nombre de la VNet
  address_space       = ["10.0.0.0/16"]                # Espacio de direcciones
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subred dedicada para la máquina virtual
resource "azurerm_subnet" "subnet_vm" {
  name                 = "subnet-vm"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subred dedicada para los nodos del clúster AKS
resource "azurerm_subnet" "subnet_aks" {
  name                 = "subnet-aks"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Grupo de Seguridad de Red (NSG) para la VM
resource "azurerm_network_security_group" "nsg_vm" {
  name                = "nsg-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Regla para permitir el tráfico SSH entrante
  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regla para permitir el tráfico HTTP entrante
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regla para permitir el tráfico HTTPS entrante
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# IP pública para la VM
resource "azurerm_public_ip" "pip_vm" {
  name                = "pip-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# Interfaz de red (NIC) para la VM
resource "azurerm_network_interface" "nic_vm" {
  name                = "nic-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-vm"
    subnet_id                     = azurerm_subnet.subnet_vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_vm.id
  }
}

# Asociación del NSG a la NIC de la VM
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic_vm.id
  network_security_group_id = azurerm_network_security_group.nsg_vm.id
}