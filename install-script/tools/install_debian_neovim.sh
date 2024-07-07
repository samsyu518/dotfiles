#!/bin/bash

sudo apt-get -y install ninja-build gettext cmake unzip curl build-essential ripgrep jq 

(cd ~ ;  git clone https://github.com/neovim/neovim )
(cd ~/neovim && git checkout release-0.10 && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install)

