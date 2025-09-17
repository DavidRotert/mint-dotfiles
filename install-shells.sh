#!/bin/bash

set -euo pipefail

script_dir="$(dirname "$(readlink -f "$0")")"

oh_my_posh_version="v26.23.5"
fastfetch_version="2.52.0"
jetbrains_mono_version="2.304"
jetbrains_mono_nerdfont_version="v3.4.0"

echo "=== Install dependencies"
sudo apt install wget unzip git

echo "=== Install ZSH and shell tools"
sudo apt install \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    fzf \
    zoxide \
    tmux \
    neovim \
    tldr

sudo wget -O /usr/local/bin/oh-my-posh "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/$oh_my_posh_version/posh-linux-amd64"
sudo chmod +x /usr/local/bin/oh-my-posh

wget -O /tmp/fastfetch.deb "https://github.com/fastfetch-cli/fastfetch/releases/download/$fastfetch_version/fastfetch-linux-amd64.deb"
sudo apt install /tmp/fastfetch.deb

echo "=== Download and install fonts"
mkdir -p /usr/local/share/fonts

wget -O /tmp/jetbrains-mono.zip "https://download.jetbrains.com/fonts/JetBrainsMono-$jetbrains_mono_version.zip"
sudo unzip -jo /tmp/jetbrains-mono.zip -d /usr/local/share/fonts "fonts/ttf/*" > /dev/null

wget -O /tmp/jetbrains-mono-nerdfont.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/$jetbrains_mono_nerdfont_version/JetBrainsMono.zip"
sudo unzip -o /tmp/jetbrains-mono-nerdfont.zip -d /usr/local/share/fonts > /dev/null
