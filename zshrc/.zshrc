#!/bin/zsh

# PATHS:

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@2/libexec/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export MANPATH=$MANPATH:/opt/homebrew/share/man
export DOTFILES="$HOME/dotfiles"


# GENERAl:

# Theme
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"


# PLUGINS:

plugins=(zsh-syntax-highlighting)
source $XDG_CONFIG_HOME/.oh-my-zsh/oh-my-zsh.sh


# PACKAGES:

# Thefuck
eval $(thefuck --alias)
# Fzf
eval "$(fzf --zsh)"
# Zoxide
eval "$(zoxide init zsh)"
# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$DOTFILES/starship/starship.toml
# Carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)




# ALIASES:

# Dotfiles
alias zshconfig="nvim $DOTFILES/zshrc/.zshrc"
alias zshsource="source $DOTFILES/zshrc/.zshrc"
alias tmuxconfig="nvim $DOTFILES/tmux/tmux.conf"


# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'


# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


# General
alias cl='clear'
alias t="tmux"
alias f="fzf"
alias nv="nvim"
alias ls="lsd"
alias lsa="lsd -a"
alias cat="bat"
alias python="python3"
alias cd="z"


# Remote connections
alias guernika="ssh -p 22 a0495775@guernika.lab.inf.uc3m.es"
alias debian="ssh -p 22 tito@192.168.1.74"
alias ubuntu="ssh -p 22 tito@192.168.1.76"
alias utm="utmctl"


# Other
alias findwifipass="security find-generic-password -wa"




