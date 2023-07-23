#!/bin/bash

# Actualizar los paquetes del sistema
sudo apt-get update

# Instalar las dependencias necesarias
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common nginx

# Añadir la clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Añadir el repositorio de Docker a las fuentes de APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Actualizar los paquetes del sistema para incluir los de Docker
sudo apt-get update

# Instalar Docker
sudo apt-get install -y docker-ce

# Descargar la última versión de Docker Compose e instalarla
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Crear la red de Docker que Portainer usará para comunicarse con las instancias de Docker
sudo docker network create portainer_network

# Desplegar Portainer en Docker
sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# Agregar el repositorio de Certbot a las fuentes de APT
sudo add-apt-repository ppa:certbot/certbot -y

# Actualizar los paquetes del sistema para incluir los de Certbot
sudo apt-get update

# Instalar Certbot
sudo apt-get install -y certbot python-certbot-nginx
