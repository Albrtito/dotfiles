#!/usr/bin/env bash

RED=0xfff7768e       # TokyoNight red
GREEN=0xff9ece6a     # TokyoNight green
BLUE=0xff7aa2f7      # TokyoNight blue
YELLOW=0xffe0af68    # TokyoNight yellow
ORANGE=0xffff9e64    # TokyoNight orange
MAGENTA=0xffbb9af7   # TokyoNight magenta
GREY=0xff565f89      # TokyoNight grey
TRANSPARENT=0x00000000

sketchybar --add item space left \
    --set space \
    icon.font="$FONT:Bold:16.0" \
    icon.color=$WHITE \
    icon.padding_left=20 \
    label.drawing=off \
    background.drawing=on \
    background.color=$TRANSPARENT \
    script="$CONFIG_DIR/plugins/icon_map.sh" \
    click_script="yabai -m space --focus {index}" \
    --subscribe space space_change

for sid in $(yabai -m query --spaces | jq -r '.[].index'); do
    sketchybar --add item space.$sid left \
        --set space.$sid \
        background.padding_left=5 \
        background.padding_right=5 \
        background.height=20 \
        background.corner_radius=9 \
        background.color=0x44202331 \  # TokyoNight bg1 with alpha
        background.border_width=2 \
        background.border_color=$GREY \
        background.drawing=off \
        icon.font="$FONT:Bold:16.0" \
        icon.color=$WHITE \
        icon.padding_left=5 \
        icon.padding_right=5 \
        label.font="$FONT:Bold:16.0" \
        label.color=$WHITE \
        label.padding_left=5 \
        label.padding_right=5 \
        label.background.height=20 \
        label.background.color=0xff202331 \  # TokyoNight bg1
        label.background.drawing=on \
        label.drawing=on \
        script="$CONFIG_DIR/plugins/icon_map.sh" \
        click_script="yabai -m space --focus $sid" \
        --subscribe space.$sid space_change
done
