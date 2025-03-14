export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@2/libexec/bin:$PATH"

# ZSH Theme
ZSH_THEME="robbyrussell"


# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Plugins
plugins=(zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# USER CONFIG

# Initial shell prompt:
    #neofetch
    nerdfetch
# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITO R='nvim'
 else
   export EDITOR='mvim'
 fi



# DEFINITION OF ALIASES:

 # Config of the .zshrc file
 alias zshconfig="nvim ~/.zshrc"
 # Shorten the command to get any wifi password of networks already conected to
 alias findwifipass="security find-generic-password -wa"
 # Connect to the virtual machine of the UC3M network Guernika
 alias guernika="ssh -p 22 a0495775@guernika.lab.inf.uc3m.es"
 #Connect to the local debian linux machine
 alias debian="ssh -p 22 tito@192.168.1.74"
 #Connect to the local ubuntu linux machine
 alias ubuntu="ssh -p 22 tito@192.168.1.76"
 # Change the cd command so it no longer executes CD but zoxide, a better version of cd.

 # Alias for self control 
 alias selfcontrol="/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli"
 # Alias for utm command tools:
 alias utm="utmctl"
 # Python alias for python3 so that I don't have to write python3 every 15:50
 alias python="python3"
 # Change the cat command to bat, a better version of cat
 alias cat="bat"
# Use mupdf to directly open files: 
 alias mupdf="mupdf-gl"
# Use lsd instead of ls
alias ls="lsd"
alias lsa="lsd -a"
# Use t instead of tmux
alias t="tmux"
# Use v instead of nvim
alias v="nvim"
# Use f instead of fzf
alias f="fzf"
# Use c instead of clear
alias c="clear"


# CONFIGURATION OF COMMANDS:

 # Config Thefuck
 eval $(thefuck --alias)

 # Cconfig keybinds for fuzyfind
 eval "$(fzf --zsh)"
 
 # Config zoxide:
 eval "$(zoxide init zsh)"
 # Created by `pipx` on 2024-06-20 22:16:23
 export PATH="$PATH:/Users/tito/.local/bin"
 if [ -f "/Users/tito/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/tito/.config/fabric/fabric-bootstrap.inc"; fi

 # Include starship config: 
 eval "$(starship init zsh)"

 # CONFIGURATION OF THE CARAPACE PLUGIN:
 export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
 zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
 source <(carapace _carapace)

export MANPATH=$MANPATH:/opt/homebrew/share/man
