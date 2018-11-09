local router = require "router"
local json = require "json"

local testReq = {
	requirement = "teste"
}

local req = json.encode(testReq)

print(router.treatment(req))