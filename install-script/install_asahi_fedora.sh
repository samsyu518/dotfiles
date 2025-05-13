#!/bin/bash

sudo dnf upgrade -y
#basic build and develop tools
sudo dnf install -y git-core fastfetch neovim tmux zsh fzf ripgrep jq ncdu valkey inotify-tools vim \
    yarnpkg htop btop

#build group
#sudo dnf group install -y "C Development Tools and Libraries" "Development Tools"
sudo dnf group install c-development development-tools

sudo dnf install python3-devel mysql-devel pkgconfig

# ohmyzsh
bash ./tools/install_ohmyzsh.sh

# poetry
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/$USER/.local/bin:$PATH"
poetry self add poetry-plugin-export

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# sync tools
sudo dnf install -y restic rclone rsync

# gen zsh complete plugins
mkdir -p ~/.oh-my-zsh/custom/plugins/poetry/
poetry completions zsh >~/.oh-my-zsh/custom/plugins/poetry/_poetry
mkdir -p ~/.oh-my-zsh/custom/plugins/restic/
restic generate --zsh-completion ~/.oh-my-zsh/custom/plugins/restic/_restic
mkdir -p ~/.oh-my-zsh/custom/plugins/rclone/
rclone genautocomplete zsh ~/.oh-my-zsh/custom/plugins/rclone/_rclone
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# develop tools
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ./tools/install_lazygit.sh
bash ./tools/install_asdf.sh
bash ./tools/install_fedora_docker.sh

# dotfile install
(cd ../ && ./install)
sudo chsh -s $(which zsh) $USER

. $HOME/.asdf/asdf.sh

bash ./tools/install_asdf_plugins.sh

export PATH="$HOME/.cargo/bin/:$PATH"
