#!/bin/bash

sudo apt-get update

#basic build and develop tools
sudo apt-get -y install cmake make build-essential ninja-build gettext \
    wget curl llvm \
    libtool-bin \
    unzip zip p7zip-full xz-utils \
    ncdu inotify-tools vim zsh git htop redis-tools python3.13-venv


# ohmyzsh
bash ./tools/install_ohmyzsh.sh

# sync tools
sudo apt-get -y install rsync

# develop tools

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

curl https://mise.run | sh
bash ./tools/install_debian_docker.sh

# dotfile install
(cd ../ && ./install)
sudo chsh -s $(which zsh) $USER

bash ./tools/install_mise_plugins.sh
