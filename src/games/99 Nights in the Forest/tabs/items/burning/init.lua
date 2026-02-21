local Workspace = game:GetService("Workspace")
local functions = require("../../../modules/functions")
local connections = {
	autoburn = {}
}

local toburn = {
	["Logs"] = "Log",
	["Chairs"] = "Chair",
	["Coal"] = "Coal",
	["Fuel Canisters"] = "Fuel Canister",
	["Oil Barrels"] = "Oil Barrel",
}

function init(ui)
	local burning = ui:TreeNode({
		Title = "Burning",
	})
	do
		for itemName, itemValue in pairs(toburn) do
			burning:Button({
				Text = "Burn ALL " .. itemName,
				Callback = function()
					local items = functions.searchItems(itemValue)

					for _, i in pairs(items) do
						functions.burn(i)
					end
				end,
			})
		end

		burning:Separator()

		for itemName, itemValue in pairs(toburn) do
			burning:Checkbox({
				Label = "Auto Burn " .. itemName,
				Callback = function(self, val)
					if val then
						local items = functions.searchItems(itemValue)

						for _, i in pairs(items) do
							functions.burn(i)
						end

						connections.autoburn[itemValue] = Workspace:FindFirstChild("Items").ChildAdded:Connect(function(child)
							if child.Name == itemValue then
								functions.burn(child)
							end
						end)
					else
						if connections.autoburn[itemValue] then
							connections.autoburn[itemValue]:Disconnect()
							connections.autoburn[itemValue] = nil
						end
					end
				end,
			})
		end
	end
end

return init
