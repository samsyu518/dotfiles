#!/bin/bash

sudo dnf install -y keepassxc kitty

wget -P /tmp/ "https://github.com/andirsun/Slacky/releases/download/v0.0.5/slacky-0.0.5.aarch64.rpm"

sudo dnf install -y /tmp/slacky-0.0.5.aarch64.rpm

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser fcitx5-rime

sudo echo 'KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="80", ATTR{charge_control_start_threshold}="75"' >/etc/udev/rules.d/99-asahi-battery.rules

sudo echo 80 >/sys/class/power_supply/macsmc-battery/charge_control_end_threshold
sudo echo 75 >/sys/class/power_supply/macsmc-battery/charge_control_start_threshold

sudo echo 'options hid-apple fnmode=2' >/etc/modprobe.d/keyboard.conf
sudo echo 'options hid-apple swap_opt_cmd=1' >>/etc/modprobe.d/keyboard.conf
sudo dracut --regenerate-all --force

dnf copr enable -y solopasha/hyprland
sudo dnf install -y hyprland hyprland-devel      # If you want to build plugins (use hyprpm)
sudo dnf install -y hyprpanel hyprpaper hyprlock # hyperland tools
sudo dnf install -y Rofi-wayland blueman
# ghostty
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty-git
