#!/bin/bash

:<<'SCRIPT DEFINITION'
This script is used to change the system theme based on the defined 
environment variable $THEME.
It alters:
+ The terminal (ghostty) theme by deleting the first line of the config and adding a new one with the new theme
It does NOT alter:
+ The theme from nvim, this is done automatically within nvim
SCRIPT DEFINITION


DEFAULT_THEME="kanagawa"
unset THEME

# Function for setting ghostty theme
set_ghostty_theme() {
    local theme="$1"
    local config_file="$XDG_CONFIG_HOME/ghostty/config"
    
    # Set the actual theme name for ghostty config (without quotes, as shown in current config)
    if [ "$theme" = "kanagawa" ]; then
        gh_theme="kanagawa wave"
    elif [ "$theme" = "catppuccin" ]; then
        gh_theme="catppuccin-mocha"
    elif [ "$theme" = "rose-pine" ]; then
        gh_theme="rose-pine-dawn"
    elif [ "$theme" = "dayfox" ]; then
        gh_theme="dayfox"
    elif [ "$theme" = "dawnfox" ]; then
        gh_theme="dawnfox"
    elif [ "$theme" = "nightfox" ]; then
        gh_theme="nightfox"
    fi
    
    # Create a temporary file
    temp_file=$(mktemp)
    
    # Based on your current config, write just the theme name without "theme = " prefix
    echo "theme="$gh_theme"" > "$temp_file"
    
    # Append the rest of the original file (excluding first line)
    if [ -f "$config_file" ]; then
        tail -n +2 "$config_file" >> "$temp_file"
        # Replace original file with our new version
        mv "$temp_file" "$config_file"
        echo "Updated ghostty theme to $gh_theme"
        echo "Remember to reload ghostty with cmd+S+,"
    else
        echo "Error: Config file not found at $config_file"
        rm "$temp_file"
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
    # Ask for a theme from a list of available themes:
    echo -e "\nAvailable themes in the system:
\n+ kanagawa | (defaults to wave)
\n+ catppuccin | (defaults to mocha)
\n+ rose-pine | (defaults to dawn)\n
\n+ dayfox\n
\n+ nightfox\n
\n+ dawnfox\n"
    # Check if we're in an interactive shell
    if [ -t 0 ]; then
        # Use shell-appropriate read command
        if [ -n "$ZSH_VERSION" ]; then
            # ZSH version
            echo -n "Name of the target theme: ($DEFAULT_THEME) "
            read NEW_THEME
        else
            # Bash version
            read -p "Name of the target theme: ($DEFAULT_THEME) " NEW_THEME
        fi
        NEW_THEME=${NEW_THEME:-$DEFAULT_THEME}
    else
        # If not interactive, take the first argument or use default
        NEW_THEME=${1:-$DEFAULT_THEME}
    fi
    NEW_THEME=${NEW_THEME:-$DEFAULT_THEME}
    export THEME=$NEW_THEME
    #echo "Theme changed to $NEW_THEME"
    set_ghostty_theme "$NEW_THEME"
}

# Check if the script is being sourced or executed directly
# This prevents set_global_theme from running when the alias calls the script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is being executed directly, not sourced
    change_global_theme
else
    # Script is being sourced, initialize the theme
    set_global_theme
fi
