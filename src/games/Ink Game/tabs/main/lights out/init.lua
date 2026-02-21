local cast = require("../../../../../modules/services")

local pfunctions = require("../../../../../modules/functions")
local player = cast("Players").LocalPlayer

function init(ui)
	local lightsout = ui:TreeNode({
		Title = "Lights Out",
	})
	do
		lightsout:SliderInt({
			Label = "Hip Height",
			Value = pfunctions.getHumanoid(player).HipHeight or 0,
			Minimum = 0,
			Maximum = 50,
			Callback = function(self, val)
				if pfunctions.isAlive() then
					local humanoid = pfunctions.getHumanoid(player)

					if humanoid then
						humanoid.HipHeight = val
					end
				end
			end,
		})
	end
end

return init
