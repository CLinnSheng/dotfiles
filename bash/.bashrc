#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias
alias ls='ls --color=auto -lSh'
alias ll='ls --color=auto -lth'
alias grep='grep --color=auto'
alias image='nsxiv'

# PATH
if [ -d "$HOME/bin/" ]
then PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.bin/" ]
then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]
then PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR="nvim"

# History Configuration
export HISTTIMEFORMAT="%F %T"

# Vi Mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# ignore upper and lowercase when tab
bind "set completion-ignore-case on"

# flags for some command
alias free='free -m' # in MB

alias gc='clean_branch'

# fzf
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

# run fastfetch command whenever open terminal
# if [ -f /usr/bin/fastfetch ]; then
#     fastfetch
# fi

# Start starship
eval "$(starship init bash)"
. "$HOME/.cargo/env"
