#!/bin/bash
mkdir -p ~/.build
git clone https://github.com/lemonade-command/lemonade.git ~/.build/lemonade
cd ~/.build/lemonade && make install

