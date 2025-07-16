# terraform/key_vault.tf

# Define el recurso de Azure Key Vault.
resource "azurerm_key_vault" "kv" {
  name                = "kv${random_string.random.result}" # Nombre único
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

# Recurso para obtener la información del usuario/sesión actual.
data "azurerm_client_config" "current" {}

# Define el secreto que se guardará en el Key Vault.
resource "azurerm_key_vault_secret" "acr_password_secret" {
  name         = "acr-admin-password" # Nombre del secreto dentro del vault
  value        = azurerm_container_registry.acr.admin_password
  key_vault_id = azurerm_key_vault.kv.id
}