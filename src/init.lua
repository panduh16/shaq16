local success, errormsg = pcall(function()
	require("./keysystem")
	require("./modules/anti-afk")
	require("./modules/analytics")

	if not getgenv().Debugging then
		local loader = require("./games")

		loader(game.GameId)
	else
		require("./debug")
	end
end)

if not success then
	local warn = require("./modules/warn")

	warn(errormsg)
end
