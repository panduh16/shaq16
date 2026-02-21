local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local connections = {}

function init(ui)
	local squidgame = ui:TreeNode({
		Title = "Squid Game",
	})
	do
		squidgame:Button({
			Text = "Teleport To Center",
			Callback = function()
				functions.teleportTo(CFrame.new(-1173, 640, -1477))
			end,
		})

		squidgame:Checkbox({
			Label = "Spam Teleport Above Center",
			Callback = function(self, val)
				if val then
					if connections["Spam Teleport Above Center"] then
						connections["Spam Teleport Above Center"]:Disconnect()
						connections["Spam Teleport Above Center"] = nil
					end
					connections["Spam Teleport Above Center"] = RunService.Heartbeat:Connect(function()
						functions.teleportTo(CFrame.new(-1173, 690, -1477))
					end)
				else
					if connections["Spam Teleport Above Center"] then
						connections["Spam Teleport Above Center"]:Disconnect()
						connections["Spam Teleport Above Center"] = nil
					end
				end
			end,
		})
	end
end

return init
