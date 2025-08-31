#!/bin/bash

# Install Podman
sudo apt install \
    podman \
    podman-compose \
    containers-storage

# Install Docker
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-rootless-extras docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker_config="$(cat <<EOF
{
    "default-address-pools": [
        {
            "base":"172.17.0.0/16",
            "size": 24
        }
    ]
}
EOF
)"
sudo mkdir -p /etc/docker
echo "$docker_config" | sudo tee > /etc/docker/daemon.json
dockerd-rootless-setuptool.sh install
docker_rootless_config="$(cat <<EOF
{
    "default-address-pools": [
        {
            "base":"172.18.0.0/16",
            "size": 24
        }
    ]
}
EOF
)"
sudo mkdir -p "$HOME/.config/docker"
echo "$docker_rootless_config" | sudo tee > "$HOME/.config/docker/daemon.json"

# Install virtualization tools
sudo apt install virt-manager

# Install desktop apps
sudo apt install \
    copyq \
    variety \
    color-picker \
    gnome-characters \
    vlc \
    gimp \
    remmina \
    nextcloud-desktop
