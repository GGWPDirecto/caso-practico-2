# Define el grupo de recursos que contendrá toda la infraestructura del proyecto.
resource "azurerm_resource_group" "rg" {
  name     = "rg-casopractico2"
  location = var.location
}