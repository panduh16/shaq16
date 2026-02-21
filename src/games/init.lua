local games = {
	[7326934954] = function()
		require("./99 Nights in the Forest")
	end,
	[7629331599] = function()
		require("./Prospecting")
	end,
	[7008097940] = function()
		require("./Ink Game")
	end,
	[8013928798] = function()
		require("./Build a Brainrot")
	end,
}

local function loader(gameId)
	local loadGame = games[gameId]

	if loadGame then
		loadGame()
	else
		warn("No game support found")
	end
end

return loader
