local json = require "json"

local router = {}

function routement(msg)
	if msg == "teste" then return "success!"
	else return "error" end

end

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