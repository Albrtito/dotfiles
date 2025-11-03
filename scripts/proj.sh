#!/bin/bash

# Create directories
mkdir doc
mkdir res
mkdir src
mkdir scripts
mkdir src/tests

# Init documentation
zk init "doc/"
touch doc/log.md
touch README.md
touch doc/report.md

# Create a gitignore
echo
"
AGENTS.md 
" >.gitignore
# Init git
git init
git add .
git commit -m "initial commit"
