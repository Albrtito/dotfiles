!#/bin/bash

stow -v . 
stow -v --target=$HOME tmux

# Set up zsh path to config
echo "export HISTFILE="$HOME/.local/share/zsh/history"" >> $HOME/.zshenv
echo "export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"" >> $HOME/.zshenv
echo "export ZDOTDIR="$HOME/.config/zshrc"" >> $HOME/.zshenv
