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
poetry self add poetry-plugin-export

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# sync tools
yay -S --noconfirm restic rclone rsync

# zsh autocomplete plugins
mkdir -p ~/.oh-my-zsh/custom/plugins/poetry/
poetry completions zsh > ~/.oh-my-zsh/custom/plugins/poetry/_poetry
mkdir -p ~/.oh-my-zsh/custom/plugins/restic/
restic generate --zsh-completion ~/.oh-my-zsh/custom/plugins/restic/_restic
mkdir -p ~/.oh-my-zsh/custom/plugins/rclone/
rclone genautocomplete zsh ~/.oh-my-zsh/custom/plugins/rclone/_rclone

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# develop tools
yay -S --noconfirm emacs fastfetch \
    docker docker-compose mysql-clients erlang elixir aspell-en aspell xsel \
    ripgrep the_silver_searcher fd locate ttf-fira-code \
    rlwrap clojure leiningen jdk-openjdk \
    yarn nodejs npm htop btop glances jq less net-tools lsof ncdu rustup go redis \
    google-cloud-cli inotify-tools bind fzf inetutils
 
yay -S --noconfirm lazygit-git google-cloud-cli clj-kondo-bin 

# font install
yay -S --noconfirm adobe-source-han-sans-otc-fonts adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts \
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
