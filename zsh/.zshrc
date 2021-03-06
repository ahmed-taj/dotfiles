#!/bin/zsh
# uncomment this and the last line for zprof info
# zmodload zsh/zprof

export DOTFILES="$HOME/.dotfiles"

# default editors
export EDITOR='vim'
export VEDITOR='code'

# all of our zsh files
typeset -U script_files
script_files=($DOTFILES/*/*.zsh)

# load everything but completion files
for file in ${script_files:#*/completion.zsh}; do
  source "$file"
done

# Starship prompt
eval "$(starship init zsh)"

# enable completion
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# load antibody plugins
source $HOME/.zsh_plugins.sh

# load completion files
for file in ${(M)script_files:#*/completion.zsh}; do
  source "$file"
done

unset script_files

# use .localrc for local machine configs.
if [ -f "$HOME/.localrc" ]; then
	. "$HOME/.localrc"
fi

# zprof
