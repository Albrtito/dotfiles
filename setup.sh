#!/bin/bash

stow -v -R . 
stow -v -R --target=$HOME git

# Set up zsh path to config
rm -rf $HOME/.zshenv
echo "export HISTFILE="$HOME/.local/share/zsh/history"" >> $HOME/.zshenv
echo "export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"" >> $HOME/.zshenv
echo "export ZDOTDIR="$HOME/.config/zshrc"" >> $HOME/.zshenv
echo "export XDG_CONFIG_HOME="$HOME/.config"" >> $HOME/.zshenv

# Homebrew
cd homebrew
brew bundle 
