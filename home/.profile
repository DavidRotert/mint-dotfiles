# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

[ -f "$HOME/.oh-my-shells/shared/env" ] && . "$HOME/.oh-my-shells/shared/env"
[ -f "$HOME/.oh-my-shells/shared/env_custom" ] && . "$HOME/.oh-my-shells/shared/env_custom"
[ -f "$HOME/.oh-my-shells/shared/aliases" ] && . "$HOME/.oh-my-shells/shared/aliases"
[ -f "$HOME/.oh-my-shells/shared/aliases_custom" ] && . "$HOME/.oh-my-shells/shared/aliases_custom"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export EDITOR="/usr/bin/nano"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
