local socket = require "socket"
local router = require "router"

local server, ip = socket.dns.toip("localhost"), 80324

local server, err = assert(socket.bind(server, ip))

if err then
	print("an error ocourred, try again", err)
	return 1
end

while true do
	local client = server:accept()
	msg = client:receive()

	print(msg)

	response = assert(router.treatment(msg))

	print(response)

	client:send(response .. "\n")

	client:close()
end