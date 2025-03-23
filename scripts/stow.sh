#!/bin/bash
cd ..
stow -v -R . 
stow -v -R --target=$HOME git
stow -v -R --target=$HOME tmux
