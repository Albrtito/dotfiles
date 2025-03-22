#!/bin/bash

# Brewfile and leaves
cd ../homebrew
brew bundle dump
brew leaves > leaves.txt
