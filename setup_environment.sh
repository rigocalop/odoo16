#!/bin/bash

# Actualizar los paquetes existentes
sudo apt update -y

# Instalar Docker
sudo apt install -y docker.io

# Instalar Docker Compose
sudo apt install -y docker-compose

# Instalar Nginx
sudo apt install -y nginx

# Instalar Certbot (Let's Encrypt)
sudo apt install -y certbot python3-certbot-nginx

# Instalar PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# Instalar Portainer
docker volume create portainer_data
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# Instalar net-tools
sudo apt install -y net-tools

# Añadir la clave de Microsoft
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Instalar .NET SDK
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-6.0

# Limpiar
sudo apt autoremove
sudo apt autoclean
rm packages-microsoft-prod.deb