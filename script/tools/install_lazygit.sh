#!/bin/bash

# Check the system architecture
arch=$(uname -m)

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if [ "$arch" == "x86_64" ]; then
    filename="lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
elif [ "$arch" == "aarch64" ]; then
    filename="lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
else
    echo "Unsupported architecture: $arch"
    exit 1
fi
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/${filename}"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

