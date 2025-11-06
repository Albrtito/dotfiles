#!/usr/bin/env bash

# Pomodoro Timer Helper Script
# =============================
# Manages the state of a pomodoro timer with work (25 min) and break (5 min) sessions.
# 
# State is stored in temporary files:
#   - Timer state (running/stopped)
#   - Timer type (work/break)
#   - Start time
#   - Whether timer has expired (counting up in red)
#
# The script updates Sketchybar with the current timer display every second.

STATE_DIR="/tmp/sketchybar-pomodoro"
STATE_FILE="$STATE_DIR/state"
START_TIME_FILE="$STATE_DIR/start_time"
TIMER_TYPE_FILE="$STATE_DIR/timer_type"
EXPIRED_FILE="$STATE_DIR/expired"

# Create state directory if it doesn't exist
mkdir -p "$STATE_DIR"

# Initialize state files if they don't exist
[ ! -f "$STATE_FILE" ] && echo "stopped" > "$STATE_FILE"
[ ! -f "$TIMER_TYPE_FILE" ] && echo "work" > "$TIMER_TYPE_FILE"
[ ! -f "$START_TIME_FILE" ] && echo "0" > "$START_TIME_FILE"
[ ! -f "$EXPIRED_FILE" ] && echo "false" > "$EXPIRED_FILE"

# Read current state
STATE=$(cat "$STATE_FILE")
TIMER_TYPE=$(cat "$TIMER_TYPE_FILE")
START_TIME=$(cat "$START_TIME_FILE")
EXPIRED=$(cat "$EXPIRED_FILE")

# Timer durations in seconds
WORK_DURATION=$((25 * 60))   # 25 minutes
BREAK_DURATION=$((5 * 60))   # 5 minutes

# Get current timer duration based on type
if [ "$TIMER_TYPE" = "work" ]; then
    DURATION=$WORK_DURATION
else
    DURATION=$BREAK_DURATION
fi

# Format time as MM:SS
format_time() {
    local total_seconds=$1
    local minutes=$((total_seconds / 60))
    local seconds=$((total_seconds % 60))
    printf "%02d:%02d" "$minutes" "$seconds"
}

# Calculate time remaining or overtime
calculate_time() {
    local current_time=$(date +%s)
    local elapsed=$((current_time - START_TIME))
    
    if [ "$EXPIRED" = "true" ]; then
        # Timer expired, counting up
        local overtime=$((elapsed - DURATION))
        echo "$overtime|expired"
    elif [ $elapsed -ge $DURATION ]; then
        # Timer just expired
        echo "true" > "$EXPIRED_FILE"
        local overtime=$((elapsed - DURATION))
        echo "$overtime|expired"
    else
        # Timer still running
        local remaining=$((DURATION - elapsed))
        echo "$remaining|running"
    fi
}

# Update Sketchybar display
update_display() {
    if [ "$STATE" = "stopped" ]; then
        # Show initial timer value when stopped
        local display_time=$(format_time "$DURATION")
        local icon="􀐱"  # Pause icon
        sketchybar --set pomodoro \
            label="$display_time" \
            icon="$icon" \
            icon.color=0xffe2e2e3
    else
        # Timer is running
        local time_info=$(calculate_time)
        local time_value=$(echo "$time_info" | cut -d'|' -f1)
        local time_state=$(echo "$time_info" | cut -d'|' -f2)
        
        local display_time=$(format_time "$time_value")
        local icon="􀊘"  # Play icon
        
        if [ "$time_state" = "expired" ]; then
            # Red color when expired (counting up)
            sketchybar --set pomodoro \
                label="$display_time" \
                icon="$icon" \
                icon.color=0xfffc5d7c \
                label.color=0xfffc5d7c
        else
            # Normal color when running
            sketchybar --set pomodoro \
                label="$display_time" \
                icon="$icon" \
                icon.color=0xffe2e2e3 \
                label.color=0xffe2e2e3
        fi
    fi
}

# Handle commands
case "$1" in
    "toggle_timer")
        # Double-click: Start/Stop timer
        if [ "$STATE" = "stopped" ]; then
            # Starting timer - zoom in animation
            sketchybar --animate tanh 15 \
                --set pomodoro icon.scale=1.2 \
                --animate tanh 15 \
                --set pomodoro icon.scale=1.0
            
            echo "running" > "$STATE_FILE"
            echo $(date +%s) > "$START_TIME_FILE"
            echo "false" > "$EXPIRED_FILE"
        else
            # Stopping timer - bounce animation
            sketchybar --animate sin 20 \
                --set pomodoro icon.scale=0.8 \
                --animate sin 20 \
                --set pomodoro icon.scale=1.0
            
            echo "stopped" > "$STATE_FILE"
            echo "0" > "$START_TIME_FILE"
            echo "false" > "$EXPIRED_FILE"
        fi
        update_display
        ;;
    
    "switch_type")
        # Single-click: Switch between work and break timer
        # Automatically starts the new timer after switching
        
        # Rotate animation when switching
        sketchybar --animate tanh 20 \
            --set pomodoro icon.scale=0.7 icon.color=0xff8aadf4 \
            --animate tanh 20 \
            --set pomodoro icon.scale=1.0
        
        if [ "$TIMER_TYPE" = "work" ]; then
            echo "break" > "$TIMER_TYPE_FILE"
        else
            echo "work" > "$TIMER_TYPE_FILE"
        fi
        # Auto-start the timer after switching
        echo "running" > "$STATE_FILE"
        echo $(date +%s) > "$START_TIME_FILE"
        echo "false" > "$EXPIRED_FILE"
        update_display
        ;;
    
    "update")
        # Regular update (called every second)
        update_display
        ;;
    
    *)
        # Default: update display
        update_display
        ;;
esac
