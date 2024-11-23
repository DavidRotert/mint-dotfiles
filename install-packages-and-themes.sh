#!/bin/bash

script_dir="$(dirname "$(readlink -f "$0")")"

mojave_gtk_theme_tag="2024-11-15"
whitesur_icon_theme_tag="2024-09-07"
jetbrains_mono_version="2.304"
jetbrains_mono_nerdfont_version="v3.3.0"

set -euo pipefail

echo "=== Install dependencies"
sudo apt install wget stow unzip git

echo "=== Install ZSH and shells"
sudo apt install zsh zsh-syntax-highlighting zsh-autosuggestions fish terminator lsd
sudo mkdir -p /usr/local/share/zsh/themes
if [ ! -e /usr/local/share/zsh/themes/powerlevel10k ]
then
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/local/share/zsh/themes/powerlevel10k
fi

echo "=== Download and install GTK themes"
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libglib2.0-dev-bin

wget -O /tmp/Mojave-gtk-theme.zip "https://github.com/vinceliuice/Mojave-gtk-theme/archive/refs/tags/$mojave_gtk_theme_tag.zip"
unzip -o /tmp/Mojave-gtk-theme.zip -d /tmp
cd "/tmp/Mojave-gtk-theme-$mojave_gtk_theme_tag"
sudo ./install.sh --libadwaita --theme all

echo "=== Download and install icon themes"
sudo apt install papirus-icon-theme
wget -O /tmp/WhiteSur-icon-theme.zip "https://github.com/vinceliuice/WhiteSur-icon-theme/archive/refs/tags/$whitesur_icon_theme_tag.zip"
unzip -o /tmp/WhiteSur-icon-theme.zip -d /tmp
cd "/tmp/WhiteSur-icon-theme-$whitesur_icon_theme_tag"
sudo ./install.sh --theme all
sudo sed -i 's/Inherits=.*/Inherits=Papirus-Light,hicolor/g' "/usr/share/icons/WhiteSur-light/index.theme"
sudo sed -i 's/Inherits=.*/Inherits=Papirus-Dark,hicolor/g' "/usr/share/icons/WhiteSur-dark/index.theme"
sudo sed -i 's/Inherits=.*/Inherits=ePapirus,hicolor/g' "/usr/share/icons/WhiteSur/index.theme"
for color in "green" "grey" "nord" "orange" "pink" "purple" "red" "yellow"
do
    sudo sed -i 's/Inherits=.*/Inherits=Papirus-Light,hicolor/g' "/usr/share/icons/WhiteSur-$color-light/index.theme"
    sudo sed -i 's/Inherits=.*/Inherits=Papirus-Dark,hicolor/g' "/usr/share/icons/WhiteSur-$color-dark/index.theme"
    sudo sed -i 's/Inherits=.*/Inherits=ePapirus,hicolor/g' "/usr/share/icons/WhiteSur-$color/index.theme"
done

echo "=== Download and install fonts"
mkdir -p /usr/local/share/fonts

wget -O /tmp/jetbrains-mono.zip "https://download.jetbrains.com/fonts/JetBrainsMono-$jetbrains_mono_version.zip"
sudo unzip -jo /tmp/jetbrains-mono.zip -d /usr/local/share/fonts "fonts/ttf/*"

wget -O /tmp/jetbrains-mono-nerdfont.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/$jetbrains_mono_nerdfont_version/JetBrainsMono.zip"
sudo unzip -o /tmp/jetbrains-mono-nerdfont.zip -d /usr/local/share/fonts

echo "=== Install software"
sudo apt install xcape vlc

