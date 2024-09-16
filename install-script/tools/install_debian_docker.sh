#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

distro_info=$(cat /etc/*-release 2>/dev/null)
if [[ $distro_info == *"Debian"* ]]; then
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

else 
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
mkdir -p ~/.local/bin/
arch=$(uname -m)

if [ "$arch" == "x86_64" ]; then
  DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/v2.29.3/docker-compose-linux-x86_64"
elif [ "$arch" == "aarch64" ]; then
  DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/v2.29.3/docker-compose-linux-aarch64"
else
    echo "Unsupported architecture: $arch"
    exit 1
fi

curl -SL $DOCKER_COMPOSE_URL -o ~/.local/bin/docker-compose
chmod +x ~/.local/bin/docker-compose

sudo usermod -aG docker $USER

