local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local pfunctions = require("../../../../../modules/functions")
local connections = {}
local player = cast("Players").LocalPlayer

function init(ui)
	local main = ui:TreeNode({
		Title = "Main",
	})
	do
		main:SetCollapsed(false)

		local distanceslider

		main:Checkbox({
			Label = "Spam TP",
			Callback = function(self, val)
				if val then
					if connections["Spam TP"] then
						connections["Spam TP"]:Disconnect()
						connections["Spam TP"] = nil
					end
					connections["Spam TP"] = RunService.Heartbeat:Connect(function()
						local plr = functions.getClosestPlr()

						if plr then
							local root = pfunctions.getRoot(plr)

							functions.teleportTo(CFrame.new(root.Position) + distanceslider:GetValue().Position)
						end
					end)
				else
					if connections["Spam TP"] then
						connections["Spam TP"]:Disconnect()
						connections["Spam TP"] = nil
					end
				end
			end,
		})

		distanceslider = main:SliderCFrame({
			Label = "Distance From Player",
			Value = CFrame.new(0, 0, 0),
			Minimum = CFrame.new(-5, -5, -5),
			Maximum = CFrame.new(5, 5, 5),
		})

		main:Checkbox({
			Label = "Face Nearest Player",
			Callback = function(self, val)
				if val then
					if connections["Face Nearest Player"] then
						connections["Face Nearest Player"]:Disconnect()
						connections["Face Nearest Player"] = nil
					end
					connections["Face Nearest Player"] = RunService.Heartbeat:Connect(function()
						local plr = functions.getClosestPlr()

						if plr then
							local root = pfunctions.getRoot(plr)

							pfunctions.lookAt(root.CFrame.Position)
						end
					end)
				else
					if connections["Face Nearest Player"] then
						connections["Face Nearest Player"]:Disconnect()
						connections["Face Nearest Player"] = nil
					end
				end
			end,
		})
	end
end

return init
