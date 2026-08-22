#!/bin/bash

# yay
(cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm)
# ohmyzsh
bash ./tools/install_ohmyzsh.sh

# tmux tpm
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# sync tools
yay -S --noconfirm restic rclone rsync syncthing fuse3

# zsh autocomplete plugins
mkdir -p ~/.oh-my-zsh/custom/plugins/rclone/
rclone genautocomplete zsh ~/.oh-my-zsh/custom/plugins/rclone/_rclone


# develop tools
yay -S --noconfirm emacs fastfetch \
    docker docker-compose mysql-clients erlang elixir aspell-en aspell xsel \
    the_silver_searcher fd locate ttf-fira-code \
    rlwrap clojure leiningen jdk-openjdk \
    yarn nodejs npm htop btop glances less net-tools lsof ncdu go valkey luarocks \
    inotify-tools bind stylua inetutils php composer xdebug pacman-contrib

# font install
yay -S --noconfirm adobe-source-han-sans-otc-fonts adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts \
    wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei \
    ttf-arphic-ukai ttf-arphic-uming noto-fonts-cjk \
    opendesktop-fonts noto-fonts-emoji \
    ttf-firacode-nerd ttf-jetbrains-mono-nerd

sudo systemctl enable docker.service
sudo usermod -aG docker $USER

curl https://mise.run | sh
# bash ./tools/install_rust.sh

# dotfile install
(cd ../ && ./install)
sudo chsh -s $(which zsh) $USER

#bash ./tools/install_asdf_plugins.sh
bash ./tools/install_mise_plugins.sh
