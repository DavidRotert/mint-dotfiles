#!/bin/bash

script_dir=$(dirname "$(readlink -f "$0")")

stow --verbose --adopt --dotfiles --target ~/ --dir "$script_dir" home
stow --verbose --adopt --dotfiles --target ~/.config --dir "$script_dir" dot-config
