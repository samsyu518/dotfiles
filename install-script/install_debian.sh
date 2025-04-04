#!/bin/bash

sudo apt-get update

#basic build and develop tools
sudo apt-get -y install cmake make build-essential ninja-build gettext libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
libtool-bin libvterm-dev \
ripgrep jq unzip zsh git htop zip p7zip-full ncdu redis-tools inotify-tools vim \
fzf

# ohmyzsh
bash ./tools/install_ohmyzsh.sh

# poetry
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/$USER/.local/bin:$PATH"
poetry self add poetry-plugin-export

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# sync tools
sudo apt-get -y install restic rclone rsync
sudo restic self-update

# gen zsh complete plugins
mkdir -p ~/.oh-my-zsh/custom/plugins/poetry/
poetry completions zsh > ~/.oh-my-zsh/custom/plugins/poetry/_poetry
mkdir -p ~/.oh-my-zsh/custom/plugins/restic/
restic generate --zsh-completion ~/.oh-my-zsh/custom/plugins/restic/_restic
mkdir -p ~/.oh-my-zsh/custom/plugins/rclone/
rclone genautocomplete zsh ~/.oh-my-zsh/custom/plugins/rclone/_rclone
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# develop tools
bash ./tools/install_tmux.sh
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ./tools/install_lazygit.sh
bash ./tools/install_asdf.sh
bash ./tools/install_debian_docker.sh
bash ./tools/install_debian_neovim.sh
bash ./tools/install_rust.sh

# dotfile install
(cd ../ && ./install)
sudo chsh -s $(which zsh) $USER

. $HOME/.asdf/asdf.sh

bash ./tools/install_asdf_plugins.sh

export PATH="$HOME/.cargo/bin/:$PATH"
