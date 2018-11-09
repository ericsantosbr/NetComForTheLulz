local socket = require "socket"
local json = require "json"

local server = socket.connect("localhost", 80324)

local reqtab = {
	requirement = "teste"
}

local msg = json.encode(reqtab) .. "\n"

io.write(msg)

server:send(msg)

response = server:receive()

print(response)

server:close()