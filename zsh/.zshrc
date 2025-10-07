#!/bin/zsh
# ===
# zsh personal config for tito
# ===

# ===
# PLUGINS:
# - without a package manager
# ===

# syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select  
zstyle ':completion:*' verbose yes  
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# bind ctr+backspace to delete words
bindkey '^H' backward-kill-word



# ===
# ENV
# ===

export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:$PATH"
export PATH=$PATH:/Users/tito/.spicetify

# homebrew
export PATH="/opt/homebrew/opt/python@2/libexec/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# rust
export PATH="/Users/tito/.cargo/bin:$PATH"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# scripts
source $XDG_CONFIG_HOME/scripts/theme.sh
export PATH="$XDG_CONFIG_HOME/scripts:$PATH"
set_global_theme
alias theme='change_global_theme'

# bat
# use bat as the pager for man pages
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# other
export XDG_CONFIG_HOME="$HOME/.config"
export MANPATH=$MANPATH:/opt/homebrew/share/man
export DOTFILES="$HOME/dotfiles"
export ZSH="$DOTFILES/zsh"
export EDITOR="/opt/homebrew/bin/nvim"
# colors in tmux
export TERM="xterm-256color"

# ===
# ALIASES:
# ===

# Dotfiles
alias zshconfig="nvim $ZSH/.zshrc"
alias zshsource="source $ZSH/.zshrc"
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

# bat
alias cat="bat"
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# remote
alias guernika="ssh -p 22 a0495775@guernika.lab.inf.uc3m.es"

# vm
alias utm="utmctl"

# nmap
alias nm="nmap -sC -sV -oN nmap"

# general
alias cl='clear'
alias t="tmux"
alias f="fzf"
alias nv="nvim"
alias ls="lsd -l"
alias lsa="lsd -la"
alias py="python3"
alias cd="z"

# other
alias findwifipass="security find-generic-password -wa"



# ===
# PACKAGES:
# ===

# fzf
eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init zsh)"

# starship
#   change the default config dir
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# carapace
#   - currently not working
#export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
#zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
#source <(carapace _carapace)



