#!/bin/bash
cd dotbot && git checkout master && cd -
git submodule foreach git pull
