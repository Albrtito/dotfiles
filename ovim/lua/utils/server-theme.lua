local socket = require("socket")
local llthreads = require("llthreads2")

-- Function to resolve hostname to IP
local function resolve_host(hostname)
    local ip = socket.dns.toip(hostname)
    if ip then
        return ip
    else
        -- Fallback to 127.0.0.1 if resolution fails
        print("Warning: Could not resolve " .. hostname .. ", using 127.0.0.1")
        return "127.0.0.1"
    end
end

local handle_petition = [[
    -- Get the param
    print("Params are",...)
    local message = ... 
    -- vim.cmd("colorscheme " .. message)
    print("Changed color scheme to" .. message)
    return ...

    ]]

local function start_server()
    -- Resolve localhost dynamically
    local host = resolve_host("localhost")
    print("Resolved localhost to:", host)
    -- Create a TCP socket and bind to resolved localhost:44645
    local server = assert(socket.tcp())
    assert(server:bind(host, 44645))
    assert(server:listen(5))
    local ip, port = server:getsockname()
    print("Server listening on", ip .. ":" .. port)
    print("Test changing color schemes")
    vim.cmd("colorscheme nightfox")
    while true do
        local client = server:accept()
        if client then
            local message, err = client:receive("*l")
            if message then
                print("Received: " .. message)
                client:send("ACK: " .. message .. "\n")
                if message == "quit" then
                    print("Quit command received, shutting down server...")
                    client:close()
                    break
                end
                -- Create thread and pass the theme as message
                local thread = llthreads.new(handle_petition,message)
                assert(thread:start(true))
                print("Thread started")
            elseif err then
                print("Receive error:", err)
            end
            client:close()
        end
    end
    server:close()
    print("Server closed")
end

start_server()
