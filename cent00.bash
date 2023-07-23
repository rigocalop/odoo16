#!/bin/bash

# Actualiza la lista de paquetes
sudo yum update -y

# Instala las herramientas necesarias para añadir repositorios adicionales
sudo yum install -y yum-utils

# Añade el repositorio oficial de Docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instala Docker CE (Community Edition)
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Habilita y arranca el servicio Docker
sudo systemctl enable docker
sudo systemctl start docker

# Instala Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Instala nginx
sudo yum install -y epel-release
sudo yum install -y nginx

# Habilita y arranca el servicio Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Verificación de la instalación
docker --version
docker-compose --version
nginx -v
