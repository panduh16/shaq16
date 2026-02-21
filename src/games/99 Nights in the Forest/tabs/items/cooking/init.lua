local functions = require("../../../modules/functions")
local connections = {
	autocook = {},
}
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local tocook = {
	["Morsel"] = "Morsel",
	["Steak"] = "Steak",
}

function init(ui)
	local cooking = ui:TreeNode({
		Title = "Cooking",
	})
	do
		for itemName, itemValue in pairs(tocook) do
			cooking:Checkbox({
				Label = "Auto Cook " .. itemName,
				Callback = function(self, val)
					if val then
						local itemss = functions.searchItems(itemValue)

						for _, i in pairs(itemss) do
							if not string.find(i.Name, "Cooked") then
								functions.cook(i)
							end
						end

						connections.autocook[itemValue] = RunService.Heartbeat:Connect(function()
							local items = functions.searchItems(itemValue)

							for _, i in pairs(items) do
								if not string.find(i.Name, "Cooked") then
									functions.cook(i)
								end
							end
						end)
					else
						if connections.autocook[itemValue] then
							connections.autocook[itemValue]:Disconnect()
							connections.autocook[itemValue] = nil
						end
					end
				end,
			})
		end

		cooking:Separator()

		cooking:Button({
			Text = "Crockpot ALL Carrots",
			Callback = function()
				if Workspace:FindFirstChild("Structures"):FindFirstChild("Crock Pot") then
					local items = functions.searchItems("Carrot")

					for _, i in pairs(items) do
						functions.grab(i)
						task.wait(0.01)
						i:PivotTo(
							Workspace:FindFirstChild("Structures"):FindFirstChild("Crock Pot").TouchZone.CFrame
								+ Vector3.new(0, -1, 0)
						)
						task.wait(0.01)
						functions.drop(i)
					end
				end
			end,
		})
	end
end

return init
