
resource "azurerm_key_vault" "kv" {
  name                = "kv${random_string.random.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Permite que el usuario que ejecuta Terraform pueda gestionar los secretos.
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = [
      "Set", "Get", "Delete", "Purge", "List"
    ]
  }
}

# Obtiene la configuración del cliente autenticado actual (usado para access_policy)
data "azurerm_client_config" "current" {}



# Guarda la contraseña de administrador del ACR como un secreto en el Key Vault
resource "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  value        = azurerm_container_registry.acr.admin_password
  key_vault_id = azurerm_key_vault.kv.id
}