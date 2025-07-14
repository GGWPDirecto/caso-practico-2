# Define el clúster de Azure Kubernetes Service (AKS).
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-casopractico2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "akscaso2"
  sku_tier            = "Standard"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.subnet_aks.id
  }

  identity {
    type = "SystemAssigned"
  }
}

# Asigna el rol 'AcrPull' a la identidad del clúster de AKS sobre el ACR.

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}