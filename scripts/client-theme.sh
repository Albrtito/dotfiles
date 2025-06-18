#!/bin/bash
# Library for communicating with Lua server on localhost:44645
# Source this file to use the functions in your scripts

# Configuration
LUA_HOST="${LUA_HOST:-localhost}"
LUA_PORT="${LUA_PORT:-44645}"

# Function to send a message (returns immediately)
send_message() {
    local message="$1"
    if [ -z "$message" ]; then
        echo "Error: No message provided" >&2
        return 1
    fi
    echo "$message" | nc "$LUA_HOST" "$LUA_PORT"
}

# Function to send message and wait for response
send_and_receive() {
    local message="$1"
    if [ -z "$message" ]; then
        echo "Error: No message provided" >&2
        return 1
    fi
    echo "Sending: $message"
    echo "$message" | nc "$LUA_HOST" "$LUA_PORT"
    echo "---"
}

# Function to check if the required dependencies are available
check_lua_client_deps() {
    if ! command -v nc &> /dev/null; then
        echo "Error: netcat (nc) is not installed. Please install it first:" >&2
        echo "  On macOS: brew install netcat" >&2
        echo "  On Ubuntu/Debian: sudo apt-get install netcat" >&2
        return 1
    fi
    return 0
}

# Function to test connection to Lua server
test_lua_connection() {
    if echo "ping" | timeout 3 nc "$LUA_HOST" "$LUA_PORT" &>/dev/null; then
        echo "Connection to Lua server successful"
        return 0
    else
        echo "Error: Cannot connect to Lua server at $LUA_HOST:$LUA_PORT" >&2
        return 1
    fi
}

# Function for interactive mode (if needed)
lua_interactive() {
    echo "Interactive mode - type messages (type 'quit' to exit)"
    while true; do
        read -p "Message: " message
        if [ -z "$message" ]; then
            continue
        fi
        send_and_receive "$message"
        if [ "$message" = "quit" ]; then
            break
        fi
    done
}

# Only run the dependency check if this script is sourced
# (This won't run when the script is executed directly)
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    # Script is being sourced
    if ! check_lua_client_deps; then
        echo "Warning: Dependencies not met for Lua client functions" >&2
    fi
fi
