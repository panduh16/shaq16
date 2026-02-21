local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local player = cast("Players").LocalPlayer
local connections = {}
local pfunctions = require("../../../../../modules/functions")

function init(ui)
	local extra = ui:TreeNode({
		Title = "Extra",
	})
	do
		extra:SetCollapsed(false)

		extra:Button({
			Text = "Teleport To Lobby",
			Callback = function()
				functions.teleportTo(CFrame.new(197, 54.5, -102))
			end,
		})

		local minHealth

		extra:Checkbox({
			Label = "TP To Safety If Low Health",
			Callback = function(self, val)
				if val then
					if connections["TP To Safety If Low Health"] then
						connections["TP To Safety If Low Health"]:Disconnect()
						connections["TP To Safety If Low Health"] = nil
					end
					connections["TP To Safety If Low Health"] = RunService.Heartbeat:Connect(function()
						local humanoid = pfunctions.getHumanoid(player)

						if humanoid then
							if humanoid.Health < minHealth:GetValue() and not functions.checkGame() == "SquidGame" then
								functions.teleportTo(CFrame.new(197.55394, 90.571579, -95.3196716))
							elseif humanoid.Health < minHealth:GetValue() then
								functions.teleportTo(CFrame.new(-1173, 680, -1477))
							end
						end
					end)
				else
					if connections["TP To Safety If Low Health"] then
						connections["TP To Safety If Low Health"]:Disconnect()
						connections["TP To Safety If Low Health"] = nil
					end
				end
			end,
		})

		minHealth = extra:SliderInt({
			Label = "Minimum Health To TP",
			Value = 40,
			Minimum = 0,
			Maximum = 100,
		})
	end
end

return init
