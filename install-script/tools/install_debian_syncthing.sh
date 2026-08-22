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

# Pick which interface's IPv4 address the GUI should bind to, so it's not
# reachable from every interface (0.0.0.0) or locked to loopback only.
mapfile -t ifaces < <(ip -o -4 addr show | awk '$2 != "lo" {print $2, $4}')
echo "Select the network interface to bind the Syncthing GUI to:"
echo " 0) 127.0.0.1 (localhost only, access via SSH tunnel)"
for i in "${!ifaces[@]}"; do
  printf '%2d) %s\n' "$((i + 1))" "${ifaces[$i]}"
done
read -rp "Interface [0-${#ifaces[@]}]: " choice
if [ "$choice" = "0" ]; then
  gui_ip="127.0.0.1"
elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#ifaces[@]}" ]; then
  gui_ip="${ifaces[$((choice - 1))]#* }"
  gui_ip="${gui_ip%%/*}"
else
  echo "Invalid selection." >&2
  exit 1
fi
echo "==> Syncthing GUI will bind to ${gui_ip}:8384"

sudo tee -a /etc/systemd/system/syncthing@.service.d/nospam.conf >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/syncthing serve --no-browser --no-restart --log-level=WARN --gui-address=${gui_ip}:8384

EOF

# after install run this
# > sudo systemctl daemon-reload
# > sudo systemctl enable --now syncthing@username
