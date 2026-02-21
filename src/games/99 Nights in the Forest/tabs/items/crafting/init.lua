local functions = require("../../../modules/functions")
local connections = {
	autocraft = {},
}
local RunService = game:GetService("RunService")

function init(ui)
	local crafting = ui:TreeNode({
		Title = "Crafting",
	})
	do
		crafting:Button({
			Text = "Craft ALL Metal",
			Callback = function()
				local item = functions.getItems()

				for _, i in pairs(item) do
					if i:GetAttribute("Scrappable") then
						functions.scrap(i)
					end
				end
			end,
		})

		crafting:Button({
			Text = "Craft ALL Wood",
			Callback = function()
				local item = functions.getItems()

				for _, i in pairs(item) do
					if string.lower(i.Name) == ("log" or "chair") then
						functions.scrap(i)
					end
				end
			end,
		})

		crafting:Checkbox({
			Label = "Auto Craft Metal",
			Callback = function(self, val)
				if val then
					local itemm = functions.getItems()

					for _, i in pairs(itemm) do
						if i:GetAttribute("Scrappable") then
							functions.scrap(i)
						end
					end
					connections.autocraft["Metal"] = RunService.Heartbeat:Connect(function()
						local item = functions.getItems()

						for _, i in pairs(item) do
							if i:GetAttribute("Scrappable") then
								functions.scrap(i)
							end
						end
					end)
				else
					if connections.autocraft["Metal"] then
						connections.autocraft["Metal"]:Disconnect()
						connections.autocraft["Metal"] = nil
					end
				end
			end,
		})

		crafting:Checkbox({
			Label = "Auto Craft Wood",
			Callback = function(self, val)
				if val then
					local itemm = functions.getItems()

					for _, i in pairs(itemm) do
						if string.lower(i.Name) == ("log" or "chair") then
							functions.scrap(i)
						end
					end
					connections.autocraft["Wood"] = RunService.Heartbeat:Connect(function()
						local item = functions.getItems()

						for _, i in pairs(item) do
							if string.lower(i.Name) == ("log" or "chair") then
								functions.scrap(i)
							end
						end
					end)
				else
					if connections.autocraft["Wood"] then
						connections.autocraft["Wood"]:Disconnect()
						connections.autocraft["Wood"] = nil
					end
				end
			end,
		})
	end
end

return init
