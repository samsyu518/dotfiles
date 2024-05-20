#!/bin/bash

(cd ~ ;  git clone https://github.com/neovim/neovim )
(cd ~/neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo && make CMAKE_INSTALL_PREFIX=$HOME/.local/nvim install)

