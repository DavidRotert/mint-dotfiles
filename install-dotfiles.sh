#!/bin/bash

script_dir=$(dirname "$(readlink -f "$0")")

stow --verbose --dotfiles --target ~/ --dir "$script_dir" home
stow --verbose --dotfiles --target ~/.config --dir "$script_dir" dot-config
stow --verbose --dotfiles --target ~/.local --dir "$script_dir" dot-local
