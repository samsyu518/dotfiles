#!/bin/bash

asdf plugin add erlang
asdf plugin add elixir
asdf plugin add python
asdf plugin add nodejs
asdf plugin add golang
asdf plugin add racket https://github.com/vic/asdf-racket.git
asdf plugin add php https://github.com/asdf-community/asdf-php.git


distro_info=$(cat /etc/*-release 2>/dev/null)

# Check for Arch Linux
if [[ $distro_info == *"Arch Linux"* ]]; then
    echo "Running commands for Arch Linux"
    yay -S --noconfirm ncurses glu mesa wxwidgets-gtk3 libpng libssh \
        unixodbc libxslt fop re2c
    export KERL_CONFIGURE_OPTIONS="--without-javac --with-odbc=/var/lib/pacman/local/unixodbc-$(pacman -Q unixodbc | cut -d' ' -f2)"
elif [[ $distro_info == *"Debian"* ]]; then
    echo "Running commands for Debian"
    sudo apt-get -y install build-essential autoconf m4 \
        libncurses5-dev libgl1-mesa-dev libglu1-mesa-dev \
        libpng-dev libssh-dev unixodbc-dev xsltproc fop \
        libxml2-utils libncurses-dev openjdk-17-jdk re2c libpq-dev

elif [[ $distro_info == *"Ubuntu"* ]]; then
    echo "Running commands for Ubuntu"
    apt-get -y install build-essential autoconf m4 \
        libncurses5-dev libgl1-mesa-dev libglu1-mesa-dev \
        libpng-dev libssh-dev unixodbc-dev xsltproc fop \
        libxml2-utils libncurses-dev openjdk-11-jdk re2c libpq-dev postgresql-libs

elif [[ $distro_info == *"Fedora"* ]]; then
    echo "Running commands for Fedora"
    sudo dnf install ncurses-devel autoconf ncurses-devel wxBase-devel wxGTK-devel openssl-devel java-21-openjdk-devel \
        libiodbc unixODBC-devel erlang-odbc libxslt fop re2c libpq-devel

else
    echo "Unsupported distribution: Unable to determine distribution information."
fi

# if need check version
# asdf list all python
asdf install python latest:3.12
# for Arch Linux
asdf install erlang latest:26
asdf install erlang latest:27
asdf install nodejs latest
asdf install golang latest
asdf install racket latest
asdf install php latest:8.1

# if [[ $distro_info == *"Arch Linux"* ]]; then
#     asdf global python system
#     asdf global erlang system
#     asdf global nodejs system
#     asdf global golang system
# else
#     asdf global python system
#     asdf global erlang 26.2.5.11
#     asdf global nodejs latest
#     asdf global golang latest
# fi

asdf set -u nodejs latest
asdf set -u golang latest
asdf set -u erlang latest:26
asdf install elixir ref:v1.16.3
asdf set -u elixir ref-v1.16.3
asdf set -u racket latest
asdf set -u php lastest:8.1
