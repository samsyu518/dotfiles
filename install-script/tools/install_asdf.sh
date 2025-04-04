#!/bin/bash

# Check the system architecture
arch=$(uname -m)

ASDF_VERSION=$(curl -s "https://api.github.com/repos/asdf-vm/asdf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if [ "$arch" == "x86_64" ]; then
    filename="asdf-v${ASDF_VERSION}-linux-amd64.tar.gz"
elif [ "$arch" == "aarch64" ]; then
    filename="asdf-v${ASDF_VERSION}-linux-arm64.tar.gz"
else
    echo "Unsupported architecture: $arch"
    exit 1
fi
curl -Lo asdf.tar.gz "https://github.com/asdf-vm/asdf/releases/download/v${ASDF_VERSION}/${filename}"
tar xvf asdf.tar.gz asdf
sudo install asdf /usr/local/bin
rm asdf asdf.tar.gz

mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

