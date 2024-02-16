#!/bin/bash

set -o errexit

#################################################################
#                   Install/Upgrade tmux
#################################################################
#
# This script installs or updates tmux onto a Debian (ie Ubuntu),
# CentOS/RHEL, or MacOS platform. This script is based on:
#   - https://github.com/tmux/tmux/wiki/Installing
#
# Can download this script using the github raw link
#   - curl -Lo tmux-install-upgrade.sh <GITHUB RAW URL>
#   - wget -O tmux-install-upgrade.sh <GITHUB RAW URL> 
#
#################################################################
#
# [ IMPORTANT ]: Run with sudo privelages!
#     sudo chmod +x tmux-install-upgrade.sh
#     sudo ./tmux-install-upgrade.sh
#
# Specify tmux version to upgrade
#   - Releases: https://github.com/tmux/tmux/releases
TARGET_VERSION="3.4"
TARGET_DIRECTORY="/usr/local/bin"
#
#################################################################


# Determine the install tool / platform
YUM=false
type yum >/dev/null 2>&1 && YUM=true
APT_GET=false
type apt-get >/dev/null 2>&1 && APT_GET=true
BREW=false
type brew  >/dev/null 2>&1 && BREW=true


# Determine if tmux is installed
TMUX_INSTALLED=false
type tmux  >/dev/null 2>&1 && TMUX_INSTALLED=true
if [ "$TMUX_INSTALLED" = true ]
then
	CURRENT_VERSION="$(tmux -V)"
else
	CURRENT_VERSION="Not Installed"
fi	


echo "=================================="
echo "Installing/Upgrading tmux ..."
echo "   Target version:   ${TARGET_VERSION}"
echo "   Current version:  ${CURRENT_VERSION}"
echo "   Directory:        ${TARGET_DIRECTORY}"
echo "=================================="
echo

# Check if tmux is already installed and/or on latest version
if [[ "$CURRENT_VERSION" == *"$TARGET_VERSION"* ]]; then
	echo "tmux version '${TARGET_VERSION}' is already installed in directory '${TARGET_DIRECTORY}'"
	exit 0
fi


# Install Compiler and needed libraries
if [ "$YUM" = true ]
then
	# RHEL or CentOS
	echo "RHEL/CentOS: Using 'yum' package manager ..."
	sudo yum update
	sudo yum install -y libevent-devel ncurses-devel gcc make bison pkg-config
	sudo yum clean all
elif [ "$APT_GET" = true ]
then
	# Debian
	echo "DEBIAN: Using 'apt-get' package manager ..."
	sudo apt-get update
	sudo apt-get install -y libevent-dev ncurses-dev build-essential bison pkg-config
	sudo apt-get clean
elif [ "$BREW" = true ]
then
	# MacOs
	echo "MacOs: Using 'brew' package manager ..."
	brew install -y libevent ncurses
else
	echo "ERROR: Package manager 'yum', 'apt-get', or 'brew' not found"
	exit 1
fi

# Download the specified version
curl -Lo "/tmp/tmux-${TARGET_VERSION}.tar.gz" "https://github.com/tmux/tmux/releases/download/${TARGET_VERSION}/tmux-${TARGET_VERSION}.tar.gz"

# Unzip the downloaded package
(cd /tmp/ && tar -zxf tmux-${TARGET_VERSION}.tar.gz)

# Get into the unzipped directory
cd /tmp/tmux-${TARGET_VERSION}/
echo "Current directory: $(pwd)"

# Build tmux from source
./configure
make clean
make
sudo make install

# Move the newly build binary into target directory
# sudo cp tmux ${TARGET_DIRECTORY}/tmux

# Back out of directory
cd ..
echo "Current directory: $(pwd)"

# Remove the unzipped directory and zip file
echo "Removing all downloaded files and unzipped directories ..."
rm "tmux-${TARGET_VERSION}.tar.gz"
sudo rm -rf "./tmux-${TARGET_VERSION}"

# Show version
echo
echo "Current tmux version: $(${TARGET_DIRECTORY}/tmux -V)"
