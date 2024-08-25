#!/bin/bash

script_dir=$(dirname "$(readlink -f "$0")")

stow --verbose --restow --dotfiles --target ~/ --dir "$script_dir" home
stow --verbose --restow --dotfiles --target ~/.config --dir "$script_dir" dot-config
