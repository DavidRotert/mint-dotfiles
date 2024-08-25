# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

color_black=0
color_red=1
color_green=2
color_yellow=3
color_blue=4
color_purple=5
color_cyan=6
color_grey=7

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color)
        PS1="${debian_chroot:+($debian_chroot)}\[$(tput setaf $color_green)$(tput bold)\]\u@\h\[$(tput sgr0)\]:\[$(tput setaf $color_blue)$(tput bold)\]\w\[$(tput sgr0)\]\$ "
        ;;
    *-256color)
        PS1="${debian_chroot:+($debian_chroot)}\[$(tput setaf $color_green)$(tput bold)\]\u@\h\[$(tput sgr0)\]:\[$(tput setaf $color_blue)$(tput bold)\]\w\[$(tput sgr0)\]\$ "
        ;;
    *)
        PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
        ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

source_if_exists "$HOME/.zshrc_custom"

source_if_exists "$HOME/.aliases"
source_if_exists "$HOME/.aliases_custom"
