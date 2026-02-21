local cast = require("../../../../../modules/services")

local functions = require("../../../modules/functions")
local pfunctions = require("../../../../../modules/functions")
local player = cast("Players").LocalPlayer
local Workspace = cast("Workspace")
local warn = require("../../../../../modules/warn")

function init(ui)
	local jumprope = ui:TreeNode({
		Title = "Jump Rope",
	})
	do
		jumprope:Button({
			Text = "Win Jump Rope [ DON'T MOVE DURING ]",
			Callback = function()
				if getconnections then
					local connections = getconnections(pfunctions.getHumanoid(player).StateChanged)

					for _, connection in pairs(connections) do
						connection:Disconnect()
					end

					for _, i in pairs(Workspace.Map.SLIGHT_IGNORE.COLLISION1:GetChildren()) do
						if i:isA("BasePart") then
							i.CanCollide = false
						end
					end
				else
					warn(
						"Your executor doesn't support getconnections, if you get prompted to do the jump minigame that is why."
					)
				end

				repeat
					task.wait()
				until pfunctions.moveTo(CFrame.new(636.1098022460938, 197.14402770996094, 920.9841918945312))

				repeat
					task.wait()
				until pfunctions.moveTo(CFrame.new(642.1098022460938, 197.14402770996094, 920.9841918945312))

				local time = tick()
				repeat
					functions.teleportTo(CFrame.new(730.1098022460938, 200.14402770996094, 920.9841918945312))
					task.wait()
				until (tick() - time) >= 2
			end,
		})
	end
end

return init
