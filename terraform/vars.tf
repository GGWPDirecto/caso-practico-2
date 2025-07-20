## Variable para el ID de suscripción de Azure
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
# Define las variables de entrada para la configuración de Terraform.

variable "location" {
  type        = string
  description = "Región de Azure donde se desplegará la infraestructura."
  default     = "Spain Central"
}

variable "ssh_user" {
  type        = string
  description = "Nombre de usuario para la conexión SSH a la máquina virtual."
  default     = "azureuser"
}

variable "ssh_key_path" {
  description = "The path to the SSH private key file."
  type        = string
  default     = "/home/user/.ssh/id_rsa" # Ruta para Ansible/WSL
}

locals {
  common_tags = {
    # Etiquetado requerido por el caso práctico.
    environment = "casopractico2"
    ManagedBy   = "Terraform"
  }
}
