#!/bin/zsh

: <<'SCRIPT DEFINITION'
This script is used to change the system theme based on the defined 
environment variable $THEME.
It alters:
+ The terminal (ghostty) theme by deleting the first line of the config and adding a new one with the new theme
It does NOT alter:
+ The theme from nvim, this is done automatically within nvim
SCRIPT DEFINITION

# The theme that will be loaded when the sheel starts
DEFAULT_THEME="nightfox"
unset THEME

# An array with all the aviable themes
aviable_themes=(
    "kanagawa"
    "catppuccin"
    "rose-pine"
    "dayfox"
    "dawnfox"
    "nightfox"
)

# A table with all the mappings between the aviable themes and their names in ghostty
declare -A ghostty_theme_mapping=(
    ["kanagawa"]="kanagawa wave"
    ["catppuccin"]="catppuccin-mocha"
    ["rose-pine"]="rose-pine-dawn"
    ["dayfox"]="dayfox"
    ["dawnfox"]="dawnfox"
    ["nightfox"]="nightfox"
)

# Nice selection function given as params a prompt to echo,
# the output value (by reference) and the options as an array
function choose_from_menu() {
    local prompt="$1" outvar="$2"
    shift 2
    local options=("$@")
    local cur=0 count=${#options[@]} index=0
    printf "$prompt\n"
    while true
    do
        # list all options (option list is zero-based)
        index=0 
        for o in "${options[@]}"
        do
            if [[ "$index" == "$cur" ]]
            then echo -e " >\e[7m$o\e[0m" # mark & highlight the current option
            else echo "  $o"
            fi
            (( index++ ))
        done
        read -s -k1 key # wait for user to key in j/k or ENTER
        if [[ $key == "k" ]] # k for up (vim-style)
        then (( cur-- )); (( cur < 0 )) && (( cur = 0 ))
        elif [[ $key == "j" ]] # j for down (vim-style)
        then (( cur++ )); (( cur >= count )) && (( cur = count - 1 ))
        elif [[ $key == $'\n' ]] # ENTER key
        then break
        fi
        echo -en "\e[${count}A" # go up to the beginning to re-render
    done
    # export the selection to the requested output variable
    ((cur++)) # Dont know what causes this error but it fixes it
    printf -v "$outvar" '%s' "${options[$cur]}"
}

# Function for setting ghostty theme
set_ghostty_theme() {
    local theme="$1"
    local config_file="$XDG_CONFIG_HOME/ghostty/config"

    # Check if theme exists in mapping
    if [[ -n "${ghostty_theme_mapping[$theme]}" ]]; then
        local gh_theme="${ghostty_theme_mapping[$theme]}"

        # Create a temporary file
        temp_file=$(mktemp)

        # Write the first line with the new theme into the ghostty config
        echo "theme="$gh_theme"" >"$temp_file"

        # Append the rest of the original file (excluding first line)
        if [ -f "$config_file" ]; then
            tail -n +2 "$config_file" >>"$temp_file"
            # Replace original file with our new version
            mv "$temp_file" "$config_file"
            echo "Updated ghostty theme to $gh_theme"
            osascript -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
            #echo "Remember to reload ghostty with cmd+S+,"
        else
            echo "Error: Config file not found at $config_file"
            rm "$temp_file"
            return 1
        fi
    else
        echo "Error: Theme '$theme' not found in available themes"
        echo "Available themes: ${aviable_themes[*]}"
        return 1
    fi
}

# Function to set the global theme
set_global_theme() {
    # Read the theme, or set the default
    export THEME=$DEFAULT_THEME
    set_ghostty_theme "$DEFAULT_THEME"
}

# Function to change the global theme
change_global_theme() {
    # Check if we're in an interactive shell
    if [ -t 0 ]; then
        # Use shell-appropriate read command
        if [ -n "$ZSH_VERSION" ]; then
            # ZSH version
            choose_from_menu "Select theme:" new_theme "${aviable_themes[@]}"
        else
            # Bash version
            echo "Change to zsh!!"
        fi
        new_theme=${new_theme:-$DEFAULT_THEME}
    else
        # If not interactive, take the first argument or use default
        new_theme=${1:-$DEFAULT_THEME}
    fi
    new_theme=${new_theme:-$DEFAULT_THEME}
    export THEME=$new_theme
    set_ghostty_theme "$new_theme"
}
