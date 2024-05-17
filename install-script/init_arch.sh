#!/bin/bash

# Initialize keyring
# https://wiki.archlinux.org/title/Pacman/Package_signing#Troubleshooting if fail
gpgconf --kill gpg-agent
rm -rf /etc/pacman.d/gnupg/
pacman-key --init
pacman-key --populate
pacman -Sy --noconfirm archlinux-keyring
pacman -Su --noconfirm

#basic build and develop tools
pacman -S --noconfirm reflector
reflector --country "Japan,South Korea,Taiwan,United States" --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -S --noconfirm base base-devel git vim neovim tmux wget zsh openssh zip unzip p7zip pigz xorg cmake python ninja ccache
ln -sf /bin/nvim /bin/vi

# locale setting
sed -i 's:#zh_TW.UTF-8 UTF-8:zh_TW.UTF-8 UTF-8:g' /etc/locale.gen
sed -i 's:#en_US.UTF-8 UTF-8:en_US.UTF-8 UTF-8:g' /etc/locale.gen
locale-gen
echo LANGUAGE=en_US.UTF-8 >> /etc/locale.conf
echo LC_ALL=en_US.UTF-8 >> /etc/locale.conf

# whell group sudo without password
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

# init default user
# Arch.exe config --default-user $username if wsl
echo "Your name? (default: arch)"
read username
username="${username:=arch}"
echo $username
useradd -m -G wheel -s /bin/bash $username
echo "passwd here:"
passwd $username

su -c './install_arch.sh' $username
