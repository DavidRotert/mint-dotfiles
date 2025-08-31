#!/bin/bash

script_dir="$(dirname "$(readlink -f "$0")")"

fastfetch_version="2.51.1"
mojave_gtk_theme_version="2024-11-15"
whitesur_icon_theme_version="2025-08-02"
jetbrains_mono_version="2.304"
jetbrains_mono_nerdfont_version="v3.4.0"
oh_my_posh_version="v26.20.1"

set -euo pipefail

echo "=== Install dependencies"
sudo apt install wget unzip git

echo "=== Install ZSH and shells"
sudo apt install \
    tmux \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    terminator \
    lsd \
    fzf \
    zoxide

sudo wget -O /usr/local/bin/oh-my-posh "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/$oh_my_posh_version/posh-linux-amd64"
sudo chmod +x /usr/local/bin/oh-my-posh

wget -O /tmp/fastfetch.deb "https://github.com/fastfetch-cli/fastfetch/releases/download/$fastfetch_version/fastfetch-linux-amd64.deb"
sudo apt install /tmp/fastfetch.deb
sudo apt remove neofetch

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

echo "=== Download and install fonts"
mkdir -p /usr/local/share/fonts

wget -O /tmp/jetbrains-mono.zip "https://download.jetbrains.com/fonts/JetBrainsMono-$jetbrains_mono_version.zip"
sudo unzip -jo /tmp/jetbrains-mono.zip -d /usr/local/share/fonts "fonts/ttf/*" > /dev/null

wget -O /tmp/jetbrains-mono-nerdfont.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/$jetbrains_mono_nerdfont_version/JetBrainsMono.zip"
sudo unzip -o /tmp/jetbrains-mono-nerdfont.zip -d /usr/local/share/fonts > /dev/null

echo "=== Install software"
sudo apt install \
    xcape \
    qt5ct \
    qt6ct
