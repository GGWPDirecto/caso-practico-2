# Fichero: Dockerfile

# Partimos de una imagen oficial y ligera de Nginx
FROM nginx:alpine

# Copiamos nuestra configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Creamos la carpeta para los certificados y los copiamos
RUN mkdir -p /etc/nginx/ssl
COPY nginx.crt /etc/nginx/ssl/nginx.crt
COPY nginx.key /etc/nginx/ssl/nginx.key

# Copiamos el fichero de autenticación
COPY .htpasswd /etc/nginx/conf.d/.htpasswd

# Copiamos nuestra página web personalizada
COPY content/ /usr/share/nginx/html

# Exponemos el puerto 443 (HTTPS)
EXPOSE 443