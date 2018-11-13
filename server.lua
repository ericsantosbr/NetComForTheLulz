--[[
	TODO: Manipulate requirements inside a thread
	TODO: Refactor the code to implement non-blocking requirement responses
	TODO: Improve retrieval of data from the client in the main server loop
]]

local socket = require "socket"
local router = require "router"
local json = require "json"

local time = ""

local server, ip = socket.dns.toip("localhost"), 80324

local server, err = assert(socket.bind(server, ip))

-- error at server creation
if err then
	print("an error ocourred, try again", err)
	return 1
end

local log = io.open("log.txt", 'a+', 'r')
log:setvbuf("no")

-- main server loop
while true do
	-- receives the connection from the client
	local client = server:accept()
	client:settimeout(0)

	local clientIp, clientPort = client:getsockname()
	
	msg = client:receive()

	time = os.date("!*t")

	log:write("[", time.hour, ":", time.min, ":", time.sec, "]", "Requirement \"", "\" coming from ", clientIp, " port ", clientPort, "\n")

	-- tries to do an requirement treatment
	response, err = assert(router.treatment(msg))

	-- sends the response to the client and then prints it
	client:send(response .. "\n")
	print(response)

	-- closes the connection
	client:close()
end

log:close()
server:close()