#!/bin/bash

sudo dnf install -y keepassxc kitty

wget -P /tmp/ "https://github.com/andirsun/Slacky/releases/download/v0.0.4/slacky-0.0.4.aarch64.rpm"

sudo dnf install -y /tmp/slacky-0.0.4.aarch64.rpm

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser fcitx5-rime
