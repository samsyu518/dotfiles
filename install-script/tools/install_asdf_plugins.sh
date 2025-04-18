#!/bin/bash

asdf plugin add erlang
asdf plugin add elixir
asdf plugin add python
asdf plugin add nodejs
asdf plugin add golang
asdf plugin-add racket https://github.com/vic/asdf-racket.git

distro_info=$(cat /etc/*-release 2>/dev/null)

# Check for Arch Linux
if [[ $distro_info == *"Arch Linux"* ]]; then
    echo "Running commands for Arch Linux"
	yay -S --noconfirm ncurses glu mesa wxwidgets-gtk3 libpng libssh \
	    unixodbc libxslt fop
elif [[ $distro_info == *"Debian"* ]]; then
    echo "Running commands for Debian"
	sudo apt-get -y install build-essential autoconf m4 \
	  libncurses5-dev libgl1-mesa-dev libglu1-mesa-dev \
	  libpng-dev libssh-dev unixodbc-dev xsltproc fop \
	  libxml2-utils libncurses-dev openjdk-17-jdk

elif [[ $distro_info == *"Ubuntu"* ]]; then
    echo "Running commands for Ubuntu"
    apt-get -y install build-essential autoconf m4 \
	libncurses5-dev libgl1-mesa-dev libglu1-mesa-dev \
	libpng-dev libssh-dev unixodbc-dev xsltproc fop \
	libxml2-utils libncurses-dev openjdk-11-jdk

elif [[ $distro_info == *"Fedora"* ]]; then
    echo "Running commands for Fedora"
    sudo dnf install ncurses-devel autoconf ncurses-devel wxBase-devel wxGTK-devel openssl-devel java-21-openjdk-devel \
    libiodbc unixODBC-devel erlang-odbc libxslt fop

else
    echo "Unsupported distribution: Unable to determine distribution information."
fi

# if need check version
# asdf list all python
# use uv vevn
# asdf install python 3.12.9
asdf install erlang 26.2.5.3
asdf install erlang 27.0.1
asdf install nodejs latest
asdf install golang latest
asdf install racket latest

if [[ $distro_info == *"Arch Linux"* ]]; then
    asdf global python system
    asdf global erlang system
    asdf global nodejs system
    asdf global golang system
else
    asdf global python system
    asdf global erlang 26.2.5.3
    asdf global nodejs latest
    asdf global golang latest
fi

asdf install elixir ref:v1.16.3
asdf install elixir ref:v1.17.2
asdf global elixir ref:v1.16.3
asdf global racket latest
