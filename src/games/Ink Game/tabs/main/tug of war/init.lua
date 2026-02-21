local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local connections = {}

function init(ui)
	local tugofwar = ui:TreeNode({
		Title = "Tug of War",
	})
	do
		tugofwar:Checkbox({
			Label = "Auto Pull",
			Callback = function(self, val)
				if val then
					if connections["Auto Pull"] then
						connections["Auto Pull"]:Disconnect()
						connections["Auto Pull"] = nil
					end
					connections["Auto Pull"] = RunService.Heartbeat:Connect(function()
						functions.pull()
					end)
				else
					if connections["Auto Pull"] then
						connections["Auto Pull"]:Disconnect()
						connections["Auto Pull"] = nil
					end
				end
			end,
		})
	end
end

return init
