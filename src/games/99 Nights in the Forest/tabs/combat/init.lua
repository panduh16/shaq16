local functions = require("../../modules/functions")
local connections = {}
local RunService = game:GetService("RunService")

function init(ui)
	local combat = ui:TreeNode({
		Title = "Combat",
	})
	do
		combat:Checkbox({
			Label = "Kill Aura",
			Callback = function(self, val)
				if val then
					connections["killaura"] = RunService.Heartbeat:Connect(function()
						functions.hit(functions.getClosestChar(), functions.getWeapon())
					end)
				else
					if connections["killaura"] then
						connections["killaura"]:Disconnect()
						connections["killaura"] = nil
					end
				end
			end,
		})

		local specific = require("./specific")
		specific(combat)
	end
end

return init
