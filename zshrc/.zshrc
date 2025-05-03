#!/bin/zsh

# PATHS:

# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@2/libexec/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/tito/.cargo/bin:$PATH"
export EDITOR="/opt/homebrew/bin/nvim"

# Enviroment variables
export XDG_CONFIG_HOME="$HOME/.config"
export MANPATH=$MANPATH:/opt/homebrew/share/man
export DOTFILES="$HOME/dotfiles"

# SCRIPTS:
source $XDG_CONFIG_HOME/scripts/theme.sh
alias theme='. $XDG_CONFIG_HOME/scripts/theme.sh && change_global_theme'

# GENERAl:

# Theme
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
# For the virtualMachines
#export TERM=vt100


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
# Currently not working
#alias debian="ssh -p 22 tito@$(${XDG_CONFIG_HOME}/scripts/utm-findIP.sh debian)"
alias ubuntu="ssh -p 22 tito@$(${XDG_CONFIG_HOME}/scripts/utm-findIP.sh ubuntu)"
alias utm="utmctl"

# Passwords
export KPASSXC_DB="$HOME/100495775@alumnos.uc3m.es - Google Drive/My Drive/Passwords.kdbx"
alias kp="keepassxc-cli ls \"$KPASSXC_DB\"" 
alias kpshow="keepassxc-cli show \"$KPASSXC_DB\""
alias kppass="keepassxc-cli show \"$KPASSXC_DB\" -a password"

# Nmap
alias nm="nmap -sC -sV -oN nmap"

# Other
alias findwifipass="security find-generic-password -wa"








. "$HOME/.local/bin/env"
