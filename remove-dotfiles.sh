#!/bin/bash

script_dir=$(dirname "$(readlink -f "$0")")

stow --verbose --adopt --delete --dotfiles --target ~/ --dir "$script_dir" home
stow --verbose --adopt --delete --dotfiles --target ~/.config --dir "$script_dir" dot-config