# Fichero principal de configuración de Terraform.

terraform {
  required_providers {
    # Se especifica que el proyecto usará una versión de la familia 4.x del proveedor de Azure.
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    # Proveedor TLS para la generación de la clave SSH.
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }

  # Configuración del backend remoto.
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "<NOMBRE_DE_TU_STORAGE_ACCOUNT>" # <- Pega aquí el nombre que creaste
    container_name       = "tfstate"
    key                  = "casopractico2.terraform.tfstate"
  }
}

# Configuración del proveedor de Azure.
provider "azurerm" {
  features {}

  # Bloque para definir etiquetas que se aplicarán a todos los recursos.
  default_tags {
    tags = {
      Project   = "CasoPractico2"
      ManagedBy = "Terraform"
    }
  }
}