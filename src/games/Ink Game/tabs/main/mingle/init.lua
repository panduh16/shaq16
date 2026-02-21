local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local connections = {}

function init(ui)
	local mingle = ui:TreeNode({
		Title = "Mingle",
	})
	do
		mingle:Checkbox({
			Label = "Auto Power Hold",
			Callback = function(self, val)
				if val then
					if connections["Auto Power Hold"] then
						connections["Auto Power Hold"]:Disconnect()
						connections["Auto Power Hold"] = nil
					end
					connections["Auto Power Hold"] = RunService.Heartbeat:Connect(function()
						functions.powerHold()
					end)
				else
					if connections["Auto Power Hold"] then
						connections["Auto Power Hold"]:Disconnect()
						connections["Auto Power Hold"] = nil
					end
				end
			end,
		})
	end
end

return init
