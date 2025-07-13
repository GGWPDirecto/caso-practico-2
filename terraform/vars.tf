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