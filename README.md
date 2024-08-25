# My dotfile and system configuration

If you install the dotfiles for the first time, run
```
stow --verbose --adopt --dotfiles --target ~/ home
```

Xfce likes to overwrite the symlinks, so to commit changes you have to run stow with the `--adopt` flag.
If you don't want to commit overwritten symlinks, do not use this flag.
