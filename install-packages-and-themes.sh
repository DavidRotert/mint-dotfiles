#!/bin/bash

script_dir="$(dirname "$(readlink -f "$0")")"

mojave_gtk_theme_tag="2024-11-15"
whitesur_icon_theme_tag="2025-02-10"
jetbrains_mono_version="2.304"
jetbrains_mono_nerdfont_version="3.3.0"
oh_my_posh_version="25.23.3"

set -euo pipefail

echo "=== Install dependencies"
sudo apt install wget unzip git

echo "=== Install ZSH and shells"
sudo apt install tmux zsh zsh-syntax-highlighting zsh-autosuggestions terminator lsd fzf zoxide

if [ ! -e /usr/local/bin/oh-my-posh ]
then
    sudo wget -O /usr/local/bin/oh-my-posh "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v$oh_my_posh_version/posh-linux-amd64"
    sudo chmod +x /usr/local/bin/oh-my-posh
fi

echo "=== Download and install GTK themes"
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libglib2.0-dev-bin

wget -O /tmp/Mojave-gtk-theme.zip "https://github.com/vinceliuice/Mojave-gtk-theme/archive/refs/tags/$mojave_gtk_theme_tag.zip"
unzip -o /tmp/Mojave-gtk-theme.zip -d /tmp > /dev/null
cd "/tmp/Mojave-gtk-theme-$mojave_gtk_theme_tag"
sudo ./install.sh --libadwaita --theme all

echo "=== Download and install icon themes"
sudo apt install papirus-icon-theme
wget -O /tmp/WhiteSur-icon-theme.zip "https://github.com/vinceliuice/WhiteSur-icon-theme/archive/refs/tags/v$whitesur_icon_theme_tag.zip"
unzip -o /tmp/WhiteSur-icon-theme.zip -d /tmp  > /dev/null
cd "/tmp/WhiteSur-icon-theme-$whitesur_icon_theme_tag"
sudo ./install.sh --theme all
sudo sed -i 's/Inherits=.*/Inherits=Papirus-Light,hicolor/g' "/usr/share/icons/WhiteSur-light/index.theme"
sudo sed -i 's/Inherits=.*/Inherits=Papirus-Dark,hicolor/g' "/usr/share/icons/WhiteSur-dark/index.theme"
sudo sed -i 's/Inherits=.*/Inherits=ePapirus,hicolor/g' "/usr/share/icons/WhiteSur/index.theme"
for color in "green" "grey" "nord" "orange" "pink" "purple" "red" "yellow"
do
    sudo sed -i 's/Inherits=.*/Inherits=Papirus-Light,hicolor/g' "/usr/share/icons/WhiteSur-$color-light/index.theme"
    sudo sed -i 's/Inherits=.*/Inherits=Papirus-Dark,hicolor/g' "/usr/share/icons/WhiteSur-$color-dark/index.theme"
    sudo sed -i 's/Inherits=.*/Inherits=Papirus,hicolor/g' "/usr/share/icons/WhiteSur-$color/index.theme"
done

echo "=== Download and install fonts"
mkdir -p /usr/local/share/fonts

wget -O /tmp/jetbrains-mono.zip "https://download.jetbrains.com/fonts/JetBrainsMono-$jetbrains_mono_version.zip"
sudo unzip -jo /tmp/jetbrains-mono.zip -d /usr/local/share/fonts "fonts/ttf/*" > /dev/null

wget -O /tmp/jetbrains-mono-nerdfont.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v$jetbrains_mono_nerdfont_version/JetBrainsMono.zip"
sudo unzip -o /tmp/jetbrains-mono-nerdfont.zip -d /usr/local/share/fonts > /dev/null

echo "=== Install software"
sudo apt install xcape vlc copyq variety
