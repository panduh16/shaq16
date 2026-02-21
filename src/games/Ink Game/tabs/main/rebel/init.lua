local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local pfunctions = require("../../../../../modules/functions")
local Workspace = cast("Workspace")
local connections = {}
local player = cast("Players").LocalPlayer

function init(ui)
	local rebel = ui:TreeNode({
		Title = "Rebel",
	})
	do
		rebel:Checkbox({
			Label = "TP Guards Infront of You",
			Callback = function(self, val)
				if val then
					if connections["TP Guards Infront of You"] then
						connections["TP Guards Infront of You"]:Disconnect()
						connections["TP Guards Infront of You"] = nil
					end
					connections["TP Guards Infront of You"] = RunService.Heartbeat:Connect(function()
						if pfunctions.isAlive(player) then
							local camera = Workspace:FindFirstChild("Camera")
							if camera then
								local camPos = camera.CFrame.Position
								local lookVec = camera.CFrame.LookVector
								local targetPos = camPos + (lookVec * 25)

								for _, guard in pairs(Workspace:FindFirstChild("Live"):GetChildren()) do
									if guard:FindFirstChild("TypeOfGuard") then
										if guard:FindFirstChild("HumanoidRootPart") then
											guard["Head"].CFrame = CFrame.new(targetPos)
											if guard:FindFirstChild("Humanoid") then
												if guard["Humanoid"].Health == 0 then
													guard:Destroy()
												end
											end
										end
									end
								end
							end
						end
					end)
				else
					if connections["TP Guards Infront of You"] then
						connections["TP Guards Infront of You"]:Disconnect()
						connections["TP Guards Infront of You"] = nil
					end
				end
			end,
		})
	end
end

return init
