
# Crea el clúster de Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-casopractico2" # Nombre del clúster
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "akscaso2"           # Prefijo DNS
  sku_tier            = "Standard"           # Nivel de servicio

  default_node_pool {
    name           = "default"               # Nombre del pool
    node_count     = 1                       # Número de nodos
    vm_size        = "Standard_DS2_v2"       # Tamaño de VM
    vnet_subnet_id = azurerm_subnet.subnet_aks.id # Subred para AKS
  }

  identity {
    type = "SystemAssigned"                  # Identidad administrada
  }
}

# Asigna el rol 'AcrPull' a la identidad del clúster de AKS para acceder al ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}