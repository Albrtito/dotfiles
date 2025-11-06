#!/usr/bin/env bash

# Media Polling Helper
# This script polls for currently playing media and directly updates Sketchybar items
# It's a workaround for cases where native media events aren't firing

IS_PLAYING=false
APP_NAME=""
TRACK_TITLE=""
TRACK_ARTIST=""

# Check if Spotify is running and playing
if pgrep -x "Spotify" > /dev/null; then
    STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
    
    if [ "$STATE" = "playing" ]; then
        IS_PLAYING=true
        APP_NAME="Spotify"
        TRACK_TITLE=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
        TRACK_ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
    fi
fi

# Check if Music app is running and playing (if Spotify isn't playing)
if [ "$IS_PLAYING" = false ] && pgrep -x "Music" > /dev/null; then
    STATE=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)
    
    if [ "$STATE" = "playing" ]; then
        IS_PLAYING=true
        APP_NAME="Music"
        TRACK_TITLE=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null)
        TRACK_ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null)
    fi
fi

# Update Sketchybar items based on playback state
if [ "$IS_PLAYING" = true ]; then
    # Show and update media items
    sketchybar --set media_cover drawing=on
    sketchybar --set media_artist drawing=on label="$TRACK_ARTIST"
    sketchybar --set media_title drawing=on label="$TRACK_TITLE"
else
    # Hide media items when nothing is playing
    sketchybar --set media_cover drawing=off
    sketchybar --set media_artist drawing=off label.width=0
    sketchybar --set media_title drawing=off label.width=0
fi
