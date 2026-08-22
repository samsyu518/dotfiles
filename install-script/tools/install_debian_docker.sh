#!/bin/bash
# Install Docker Engine from Docker's official apt repository.
# Follows https://docs.docker.com/engine/install/debian/ (deb822 + .asc key).
# Works on Debian and Ubuntu; auto-detects which repo to use.

set -euo pipefail

. /etc/os-release

case "${ID:-}${ID_LIKE:-}" in
  *ubuntu*)
    DOCKER_DISTRO=ubuntu
    # Ubuntu derivatives (Mint, Pop!_OS) carry their own VERSION_CODENAME;
    # UBUNTU_CODENAME is the one Docker's repo is keyed on.
    DOCKER_SUITE="${UBUNTU_CODENAME:-$VERSION_CODENAME}"
    ;;
  *debian*)
    DOCKER_DISTRO=debian
    DOCKER_SUITE="$VERSION_CODENAME"
    ;;
  *)
    echo "Unsupported distro: ${ID:-unknown}" >&2
    exit 1
    ;;
esac

echo "==> Installing Docker for ${DOCKER_DISTRO}/${DOCKER_SUITE} ($(dpkg --print-architecture))"

# Docker's docs ask you to drop distro-shipped packages first; they conflict
# with docker-ce. Missing packages are not an error here.
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt-get remove -y "$pkg" 2>/dev/null || true
done

sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key (ASCII-armored; apt reads .asc directly, no
# gpg --dearmor needed).
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL "https://download.docker.com/linux/${DOCKER_DISTRO}/gpg" \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Clean up the pre-deb822 layout this script used to write, so apt does not
# end up with the repo configured twice.
sudo rm -f /etc/apt/sources.list.d/docker.list /etc/apt/keyrings/docker.gpg

sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/${DOCKER_DISTRO}
Suites: ${DOCKER_SUITE}
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt-get update
sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker.service containerd.service

# Provide the hyphenated `docker-compose` command.
#
# Compose V2's plugin binary is dual-mode: it detects whether it was invoked by
# the docker CLI as a plugin or run directly, so the very same file works as a
# standalone `docker-compose`. Symlinking it beats downloading the standalone
# release: no GitHub API call, and it can never drift from the installed plugin.
COMPOSE_PLUGIN=""
for d in /usr/libexec/docker/cli-plugins /usr/lib/docker/cli-plugins \
         /usr/local/lib/docker/cli-plugins; do
  if [ -x "$d/docker-compose" ]; then
    COMPOSE_PLUGIN="$d/docker-compose"
    break
  fi
done

if [ -n "$COMPOSE_PLUGIN" ]; then
  mkdir -p ~/.local/bin
  ln -sfn "$COMPOSE_PLUGIN" ~/.local/bin/docker-compose
  echo "==> docker-compose -> $COMPOSE_PLUGIN"
  ~/.local/bin/docker-compose version
else
  echo "WARN: compose plugin not found; 'docker-compose' not linked." >&2
fi

sudo usermod -aG docker "$USER"
echo "==> Done. Log out and back in (or run: newgrp docker) for group membership to apply."
echo "==> Verify with: docker run --rm hello-world"
