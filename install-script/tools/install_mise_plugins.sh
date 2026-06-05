#!/bin/bash

distro_info=$(cat /etc/*-release 2>/dev/null)

# Check for Arch Linux
if [[ $distro_info == *"Arch Linux"* ]]; then
    echo "Running commands for Arch Linux"
    # erlang
    yay -S --noconfirm ncurses glu mesa wxwidgets-gtk3 libpng libssh \
        unixodbc libxslt fop
    # php
    yay -S re2c postgresql-libs
    export KERL_CONFIGURE_OPTIONS="--without-javac --with-odbc=/var/lib/pacman/local/unixodbc-$(pacman -Q unixodbc | cut -d' ' -f2)"
elif [[ $distro_info == *"Debian"* ]]; then
    echo "Running commands for Debian"
    # erlang
    sudo apt-get -y install build-essential autoconf m4 \
        libncurses-dev libwxgtk3.2-dev libwxgtk-webview3.2-dev \
        libgl1-mesa-dev libglu1-mesa-dev libpng-dev \
        libssh-dev unixodbc-dev xsltproc fop \
        libxml2-utils openjdk-21-jdk
    # php
    sudo apt-get -y install re2c libpq-dev postgresql-libs
    # tmux
    sudo apt-get -y install libevent-dev ncurses-dev build-essential bison pkg-config

elif [[ $distro_info == *"Ubuntu"* ]]; then
#     echo "Running commands for Ubuntu"
# erlang
apt-get -y install build-essential autoconf m4
#         libncurses5-dev libgl1-mesa-dev libglu1-mesa-dev \
#         libpng-dev libssh-dev unixodbc-dev xsltproc fop \
#         libxml2-utils libncurses-dev openjdk-21-jdk
     # php
     sudo apt-get install -y re2c libpq-dev postgresql-libs
     # tmux
     sudo apt-get -y install libevent-dev ncurses-dev build-essential bison pkg-config

#
elif [[ $distro_info == *"Fedora"* ]]; then
    echo "Running commands for Fedora"
    # erlang
    sudo dnf install -y ncurses-devel autoconf ncurses-devel wxBase-devel wxGTK-devel openssl-devel java-21-openjdk-devel \
        libiodbc unixODBC-devel erlang-odbc libxslt fop
    # php
    sudo dnf install -y re2c libpq-devel
    # tmux
    sudo dnf install -y libevent-devel ncurses-devel gcc make bison pkg-config

else
    echo "Unsupported distribution: Unable to determine distribution information."
fi

# === mise：CLI ===
mise use --global jq fd ripgrep ripgrep-all fzf just uv lazygit usage rclone restic tmux fastfetch gdu yazi tree-sitter github:neovim/neovim@nightly

# === python ：mise → uv → python / python tools ===
uv python install 3.13
uv tool install poetry --python 3.13 --with poetry-plugin-export --force

mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# gen zsh complete plugins
mkdir -p ~/.oh-my-zsh/custom/plugins/restic/
restic generate --zsh-completion ~/.oh-my-zsh/custom/plugins/restic/_restic

mkdir -p ~/.oh-my-zsh/custom/plugins/rclone/
rclone genautocomplete zsh ~/.oh-my-zsh/custom/plugins/rclone/_rclone

# fzf-tab plugin
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

mkdir -p ~/.oh-my-zsh/custom/plugins/poetry/
poetry completions zsh >~/.oh-my-zsh/custom/plugins/poetry/_poetry

# mise program
mise use -g node golang erlang@28 elixir@v1.18 php rust
#mise use -g racket
