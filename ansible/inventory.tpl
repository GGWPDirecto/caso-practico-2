# ansible/inventory.tmpl
# Plantilla de inventario para Ansible. Terraform rellenará los valores.

[vm]
${vm_ip} ansible_user=${ssh_user} ansible_ssh_private_key_file=private_key.pem

[all:vars]
acr_login_server: "${acr_login_server}"
acr_username: "${acr_username}"
acr_password: "${acr_password}"
nginx_image: "${acr_login_server}/webapp:casopractico2"