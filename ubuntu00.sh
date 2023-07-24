#!/bin/bash

# Actualizar lista de paquetes
sudo apt-get update

# Instalar las dependencias
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

# Agregar la clave oficial de GPG de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Configurar el repositorio estable de Docker
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar lista de paquetes y instalar Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Verificar la instalación de Docker
sudo docker run hello-world

# Instalar Nginx
sudo apt-get install nginx -y

# Iniciar y habilitar Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Instalar Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# Listar los contenedores de Docker para verificar que Portainer se está ejecutando
sudo docker ps
