#!/bin/bash

# Pasar las variables como argumentos al script
POSTGRES_USER=$1
POSTGRES_PASSWORD=$2
POSTGRES_PORT=$3
ADMINER_PORT=$4
PORTAINER_PORT=$5

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

# Corre Portainer como un contenedor Docker
sudo docker run -d -p $PORTAINER_PORT:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# Corre PostgreSQL y Adminer como contenedores Docker
sudo docker run --name some-postgres -e POSTGRES_USER=$POSTGRES_USER -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -d -p $POSTGRES_PORT:5432 postgres
sudo docker run --link some-postgres:db -p $ADMINER_PORT:8080 adminer

# Verificación de la instalación
docker --version
docker-compose --version
nginx -v
docker ps
