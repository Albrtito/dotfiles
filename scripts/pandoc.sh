#!/bin/bash

# Meant to be called from the location where the .md file is
pandoc report.md -o report.pdf --pdf-engine=xelatex --from markdown+tex_math_dollars -V mainfont="Iosevka" \
  -V monofont="JetBrainsMono Nerd Font Mono"
if ! lsof report.pdf >/dev/null 2>&1; then
  open report.pdf
fi
