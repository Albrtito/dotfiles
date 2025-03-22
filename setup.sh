!#/bin/bash

stow -v . 
stow -v --target=$HOME tmux

# Set up zsh path to config
echo "export ZDOTDIR="$HOME/.config/zshrc"" >> $HOME/.zshenv
