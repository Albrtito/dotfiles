#!/bin/bash

stow -v . 
stow -v --target=$HOME tmux
stow -v --target=$HOME git

# Set up zsh path to config
rm -rf $HOME/.zshenv
echo "export HISTFILE="$HOME/.local/share/zsh/history"" >> $HOME/.zshenv
echo "export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"" >> $HOME/.zshenv
echo "export ZDOTDIR="$HOME/.config/zshrc"" >> $HOME/.zshenv

# Homebrew
cd homebrew
brew bundle 
