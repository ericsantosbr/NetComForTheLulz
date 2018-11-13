local json = require "json"

local router = {}

-- main routement to treat the messages
function routement(msg)
	local response = {}
	response.requirement = msg
	if msg == "test" then
		response.msg = "success"

		response = json.encode(response)

		return response
	elseif msg == "hour" then
		local time = os.date("*t")

		response.msg = "success"
		response.hour = time.hour
		response.min = time.min
		response.sec = time.sec

		response = json.encode(response)

		return response
	else
		response.msg = "error"
		response.err = "routment not found"

		response = json.encode(response)

		return response
	end

end

-- function that starts the treatment
function router.treatment(msg)
	totreat = json.decode(msg)
	returnmsg = ""

	if not totreat then
		return nil, "invalid message"
	end

	if totreat.requirement then
		toroute = totreat.requirement
		returnmsg = routement(toroute)
	end

	return returnmsg
end

return router