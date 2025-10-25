#!/bin/bash

# Create directories
mkdir package
mkdir out

# Create files
touch package/__init__.py
touch requirements.txt

# Init venv
python3 -m venv .venv
source .venv/bin/activate
