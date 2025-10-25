#!/bin/bash

# Create directories
mkdir doc
mkdir res
mkdir src
mkdir scripts
mkdir tests

# Init documentation
zk init "doc/"
touch doc/log.md
touch README.md

# Init git
git init
git add . 
git commit -m "initial commit"
