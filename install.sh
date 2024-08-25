#!/bin/bash

script_dir=$(dirname "$(readlink -f "$0")")

"$script_dir/remove-dotfiles.sh"

stow --verbose --dotfiles --target ~/ --dir "$script_dir" home
stow --verbose --dotfiles --target ~/.config --dir "$script_dir" dot-config
