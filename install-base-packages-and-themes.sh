#!/bin/bash

set -euo pipefail

script_dir="$(dirname "$(readlink -f "$0")")"

mojave_gtk_theme_version="2024-11-15"
whitesur_icon_theme_version="2025-08-02"

echo "=== Install dependencies"
sudo apt install wget unzip git

echo "=== Download and install GTK themes"
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libglib2.0-dev-bin

wget -O /tmp/Mojave-gtk-theme.zip "https://github.com/vinceliuice/Mojave-gtk-theme/archive/refs/tags/$mojave_gtk_theme_version.zip"
unzip -o /tmp/Mojave-gtk-theme.zip -d /tmp > /dev/null
cd "/tmp/Mojave-gtk-theme-$mojave_gtk_theme_version"
sudo ./install.sh --libadwaita --theme all --opacity standard --alt standard

echo "=== Download and install icon themes"
sudo apt install papirus-icon-theme
wget -O /tmp/WhiteSur-icon-theme.zip "https://github.com/vinceliuice/WhiteSur-icon-theme/archive/refs/tags/$whitesur_icon_theme_version.zip"
unzip -o /tmp/WhiteSur-icon-theme.zip -d /tmp  > /dev/null
cd "/tmp/WhiteSur-icon-theme-$whitesur_icon_theme_version"
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

echo "=== Install base software"
sudo apt install \
    xcape \
    qt5ct \
    qt6ct
