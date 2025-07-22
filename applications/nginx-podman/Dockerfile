# Imagen personalizada de Nginx para el caso práctico
FROM docker.io/library/nginx:alpine

# Incluye el contenido personalizado
COPY content/index.html /usr/share/nginx/html/index.html

# Configuración de certificados SSL (comentado)
# COPY nginx.crt /etc/ssl/certs/nginx.crt
# COPY nginx.key /etc/ssl/private/nginx.key
# COPY nginx.conf /etc/nginx/nginx.conf

# Expón el puerto 80
EXPOSE 80
