local Workspace = game:GetService("Workspace")
local pfunctions = require("../../../../modules/functions")
local player = game:GetService("Players").LocalPlayer

function init(ui)
	local teleport = ui:TreeNode({
		Title = "Teleport",
	})
	do
		teleport:SetCollapsed(false)

		teleport:Button({
			Text = "Teleport To Campground",
			Callback = function()
				pfunctions.teleport(
					game:GetService("Workspace").Map.Campground.MainFire.Center.CFrame + Vector3.new(0, 5, 0)
				)
			end,
		})

		if Workspace:GetAttribute("AlienMothershipCF") then
			teleport:Button({
				Text = "Teleport To Alien Mothership",
				Callback = function()
					pfunctions.teleport(Workspace:GetAttribute("AlienMothershipCF"))
				end,
			})
		end

		teleport:Button({
			Text = "Explore Unlocked Map",
			Callback = function()
				local pastCFrame = pfunctions.getRoot(player).CFrame
				for _, i in
					pairs(Workspace:FindFirstChild("Map") and Workspace["Map"]:FindFirstChild("Ground"):GetChildren())
				do
					if i:IsA("BasePart") and not i:GetAttribute("Explored") then
						pfunctions.teleport(i.CFrame + Vector3.new(0, 15, 0))
						i:SetAttribute("Explored", true)
						task.wait()
					end
				end
				task.wait(0.1)
				pfunctions.teleport(pastCFrame)
			end,
		})
	end
end

return init
