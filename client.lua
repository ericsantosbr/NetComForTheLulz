local socket = require "socket"
local json = require "json"

print("Type the requirement that you want to do")
local requirement = io.read()

-- starts a connection to the server
local server = socket.connect("localhost", 80324)

-- table with the requirement
local reqtab = {
	requirement = requirement
}

if server ~= nil then
	-- encodes the requirement to a json format
	local msg = json.encode(reqtab) .. "\n"

	-- sends the requirement
	server:send(msg)

	-- gets a response
	response = server:receive()
	response = json.decode(response)

	-- treats the response
	if response.msg == "error" then
		print("error! ", response.err)
	else
		if response.requirement == "hour" then
			io.write(response.hour, ":", response.min, ":", response.sec, "\n")
		elseif response.requirement == "test" then
			print(response.msg)
		end
	end

	server:close()
else
	print("error, can't reach the server")
end