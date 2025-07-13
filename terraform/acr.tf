# Azure Container Registry (ACR) para almacenar las imágenes de contenedor.
resource "azurerm_container_registry" "acr" {
  name                = "acr${random_string.random.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Se utiliza un recurso random_string para asegurar que el nombre del ACR sea único.
resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}