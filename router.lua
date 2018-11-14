local json = require "json"

local router = {}

-- main routement to treat the messages
function routement(msg)
	local response = {}
	response.requirement = msg
	if msg == "test" then
		response.msg = "success"

		response = json.encode(response)
	elseif msg == "hour" then
		local time = os.date("*t")

		response.msg = "success"
		response.hour = time.hour
		response.min = time.min
		response.sec = time.sec

		response = json.encode(response)
	else
		response.msg = "error"
		response.err = "routment not found"

		response = json.encode(response)
	end

	return response
end

-- function that starts the treatment
function router.treatment(msg)
	returnmsg = ""
	local status, totreat = pcall(json.decode, msg)

	if status then
		print("status", totreat.requirement)
	end

	if not totreat or not status then
		print("error on requirement")
		local response = {}

		response.msg = "error"
		response.err = "routment not found"

		returnmsg = json.encode(response)
	end

	if totreat.requirement then
		toroute = totreat.requirement
		returnmsg = routement(toroute)
	end

	return returnmsg
end

return router