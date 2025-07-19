
# Crea el grupo de recursos principal donde se desplegarán todos los recursos de Azure
resource "azurerm_resource_group" "rg" {
  name     = "rg-casopractico2" # Nombre del grupo de recursos
  location = var.location        # Región de Azure donde se crearán los recursos
}