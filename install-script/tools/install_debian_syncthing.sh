#!/bin/bash

# Add the release PGP keys:
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

# Add the "stable-v2" channel to your APT sources:
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable-v2" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Update and install syncthing:
sudo apt-get update
sudo apt-get install -y syncthing inotify-tools

sudo mkdir -p /etc/systemd/system/syncthing@.service.d/

sudo tee -a /etc/systemd/system/syncthing@.service.d/override.conf >/dev/null <<EOF
[Service]
UMask=0077

EOF

sudo tee -a /etc/systemd/system/syncthing@.service.d/nospam.conf >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/syncthing serve --no-browser --no-restart --log-level=WARN

EOF

# after install run this
# > sudo systemctl daemon-reload
# > sudo systemctl enable --now syncthing@username
