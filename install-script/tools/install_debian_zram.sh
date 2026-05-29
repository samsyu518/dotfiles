#!/bin/bash



sudo apt-get update

# gcp
sudo apt install linux-modules-extra-gcp linux-image-extra-virtual

# oracle
sudo apt install linux-image-extra-virtual linux-modules-extra-$(uname -r)
# uname -a change version 6.14.0-1016-oracle
# sudo apt install linux-modules-extra-$(uname -r)
sudo apt install linux-modules-extra-6.14.0-1016-oracle

sudo apt-get install zram-tools systemd-zram-generator


sudo vi /etc/default/zramswap

ALGO=zstd
PERCENT=60

# sudo tee -a /etc/systemd/zram-generator.conf >/dev/null <<EOF
# zram-size = ram * 0.6
# compression-algorithm = zstd
#
# EOF
#
# sudo systemctl daemon-reload
# sudo systemctl start systemd-zram-setup@zram0.service
# sudo zramctl
