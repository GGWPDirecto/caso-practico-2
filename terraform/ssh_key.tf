
# Genera un par de claves SSH (privada/pública) para acceso seguro a la VM
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"   # Algoritmo de cifrado
  rsa_bits  = 4096    # Longitud de la clave
}

# Output para mostrar la clave pública generada
output "ssh_public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}
