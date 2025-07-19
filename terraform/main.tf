# terraform/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # ID de suscripción de Azure (oculto en tfvars)
}