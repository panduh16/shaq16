local RunService = game:GetService("RunService")
local functions = require("../../modules/functions")
local connections = {}
local rarities = require("../../modules/rarities")
local player = game:GetService("Players").LocalPlayer

function init(ui)
	local autolock = ui:TreeNode({
		Title = "Auto Lock",
	})
	do
		for rarity, _ in pairs(rarities) do
			autolock:Checkbox({
				Label = "Auto Lock " .. rarity,
				Callback = function(self, val)
					if val then
						connections[rarity] = RunService.Heartbeat:Connect(function()
							for _, i in pairs(player["Backpack"]:GetChildren()) do
								if
									i:GetAttribute("Rarity")
									and i:GetAttribute("Rarity") == rarity
									and not i:GetAttribute("Locked") == true
								then
									functions.lock(i)
								end
							end
						end)
					else
						if connections[rarity] then
							connections[rarity]:Disconnect()
							connections[rarity] = nil
						end
					end
				end,
			})
		end
	end
end

return init
