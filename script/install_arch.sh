#!/bin/bash

# yay 
(cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm )
# ohmyzsh
bash ./tools/install_ohmyzsh.sh

# tmux tpm
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# poetry
curl -sSL https://install.python-poetry.org | python3 -

export PATH="/home/$USER/.local/bin:$PATH"

# sync tools
yay -S --noconfirm restic rclone rsync

# zsh autocomplete plugins
mkdir -p ~/.oh-my-zsh/custom/plugins/poetry/
poetry completions zsh > ~/.oh-my-zsh/custom/plugins/poetry/_poetry
mkdir -p ~/.oh-my-zsh/custom/plugins/restic/
restic generate --zsh-completion ~/.oh-my-zsh/custom/plugins/restic/_restic
mkdir -p ~/.oh-my-zsh/custom/plugins/rclone/
rclone genautocomplete zsh ~/.oh-my-zsh/custom/plugins/rclone/_rclone

# develop tools
yay -S --noconfirm neofetch emacs macchina-bin lazygit \
    docker docker-compose mysql-clients erlang elixir aspell-en aspell xsel \
    ripgrep the_silver_searcher fd locate ttf-fira-code \
    clj-kondo-bin rlwrap clojure jdk-openjdk \
    yarn nodejs npm htop btop glances jq less net-tools lsof ncdu rustup go redis
 
# font install
yay -S adobe-source-han-sans-otc-fonts adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts \
    wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei \
    ttf-arphic-ukai ttf-arphic-uming noto-fonts-cjk \
    opendesktop-fonts noto-fonts-emoji \
    ttf-firacode-nerd ttf-jetbrains-mono-nerd

sudo systemctl enable docker.service
sudo usermod -aG docker $USER

rustup default stable

bash ./tools/install_asdf.sh

# dotfile install
(cd ../ && ./install)
sudo chsh -s $(which zsh) $USER

. $HOME/.asdf/asdf.sh

bash ./tools/install_asdf_plugins.sh

export PATH="$HOME/.cargo/bin/:$PATH"
cargo install tmux-sessionizer
