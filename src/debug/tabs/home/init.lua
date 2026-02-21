function init(ui)
	local home = ui:TreeNode({
		Title = "Home",
	})
	do
		home:SetCollapsed(false)

		-- game name
		do
			local gmnrow = home:Row()

			gmnrow:Label({
				Text = "🌐 Game Name : " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
			})

			if setclipboard then
				gmnrow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
					end,
				})
			end
		end

		-- game id
		do
			local idrow = home:Row()

			idrow:Label({
				Text = "🎮 Game Id : " .. tostring(game.GameId),
			})

			if setclipboard then
				idrow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard(tostring(game.GameId))
					end,
				})
			end
		end

		-- place id
		do
			local pidrow = home:Row()

			pidrow:Label({
				Text = "🌅 Place Id : " .. tostring(game.PlaceId),
			})

			if setclipboard then
				pidrow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard(tostring(game.PlaceId))
					end,
				})
			end
		end
	end
end

return init
