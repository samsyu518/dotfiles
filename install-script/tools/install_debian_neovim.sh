#!/bin/bash

sudo apt-get -y install ninja-build gettext cmake unzip curl build-essential ripgrep jq 

(cd ~ ;  git clone https://github.com/neovim/neovim )
(cd ~/neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install)

