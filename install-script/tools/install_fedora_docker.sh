#!/bin/bash

# Add Docker's dnf repo
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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

