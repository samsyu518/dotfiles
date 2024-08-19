#!/bin/bash

asdf plugin add erlang
asdf plugin add elixir
asdf plugin add python
asdf plugin add nodejs
asdf plugin add golang
asdf plugin add chezscheme

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
else
    echo "Unsupported distribution: Unable to determine distribution information."
fi

# if need check version
# asdf list all python
asdf install python 3.8.19
asdf install python 3.10.14
asdf install python 3.11.8
asdf install python 3.12.2
asdf install erlang 24.3.4.16
asdf install erlang 26.2.3
asdf install nodejs 21.7.1
asdf install golang 1.22.1
asdf install chezscheme latest

if [[ $distro_info == *"Arch Linux"* ]]; then
    asdf global python system
    asdf global erlang system
    asdf global nodejs system
    asdf global golang system
else
    asdf global python 3.11.8
    asdf global erlang 26.2.3
    asdf global nodejs 21.6.0
    asdf global golang 1.21.6
fi

asdf install elixir ref:v1.16.2
asdf install elixir ref:v1.15.7
asdf global elixir ref:v1.16.2
asdf global chezscheme latest
