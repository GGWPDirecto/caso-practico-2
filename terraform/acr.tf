
# Genera un sufijo aleatorio para el nombre único del ACR
resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

# Crea el Azure Container Registry (ACR) para almacenar imágenes de contenedor
resource "azurerm_container_registry" "acr" {
  name                = "acr${random_string.random.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic" # Nivel de servicio
  admin_enabled       = true    # Habilita usuario admin para autenticación
}