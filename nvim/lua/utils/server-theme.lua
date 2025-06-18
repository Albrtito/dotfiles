local socket = require("socket")
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

local function handle_petition(message)
	-- Set the new theme in themery by reloading
	vim.cmd("colorscheme " .. message)
	print("Changed color scheme")
end

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
                handle_petition(message)
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
