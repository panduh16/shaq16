local Workspace = game:GetService("Workspace")
local functions = require("../../modules/functions")

function init(ui)
	local extra = ui:TreeNode({
		Title = "Extra",
	})
	do
		extra:SetCollapsed(false)

		extra:Button({
			Text = "Infinite Yield",
			Callback = function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
			end,
		})

		extra:Button({
			Text = "Open Chests",
			Callback = function()
				functions.openChests()
			end,
		})

		extra:Button({
			Text = "Revive Injured Teammates",
			Callback = function()
				local injuredTeammates = functions.getInjuredTeammates()
				if #injuredTeammates > 0 then
					for _, teammate in pairs(injuredTeammates) do
						print(teammate.Name)
						local bandages = functions.searchItems("bandage")
						local medkits = functions.searchItems("medkit")

						local bandage = nil

						if #bandages > 0 then
							for _, item in pairs(bandages) do
								bandage = item
							end
						elseif #medkits > 0 then
							for _, item in pairs(medkits) do
								bandage = item
							end
						end

						if bandage ~= nil then
							functions.grab(teammate)
							task.wait(0.05)
							for _, okPart in pairs(teammate:GetChildren()) do
								if okPart:isA("BasePart") then
									okPart:PivotTo(
										Workspace:FindFirstChild("Map")
											:FindFirstChild("Campground")
											:FindFirstChild("MainFire").PrimaryPart.CFrame
											+ Vector3.new(0, 25, 0)
									)
								end
							end
							task.wait(0.05)
							functions.drop(teammate)
							functions.hotbar(bandage)
							functions.revive(teammate)
						end
					end
				end
			end,
		})
	end
end

return init
