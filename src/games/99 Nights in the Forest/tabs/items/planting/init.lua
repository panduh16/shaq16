local Workspace = game:GetService("Workspace")
local functions = require("../../../modules/functions")
local connections = {
	autocook = {},
}
local RunService = game:GetService("RunService")
local pfunctions = require("../../../../../modules/functions")

function init(ui)
	local planting = ui:TreeNode({
		Title = "Planting",
	})
	do
		local offset

		planting:Button({
			Text = "Plant All Saplings",
			Callback = function()
				local items = functions.searchItems("Sapling")

				for _, i in pairs(items) do
					functions.plant(
						i,
						Workspace:FindFirstChild("Map")
							:FindFirstChild("Campground")
							:FindFirstChild("MainFire").PrimaryPart.Position + offset:GetValue().Position
					)
				end
			end,
		})

		offset = planting:SliderCFrame({
			Label = "Plant Offset From Fire",
			Value = CFrame.new(15, 0, 15),
			Minimum = CFrame.new(15, 0, 15),
			Maximum = CFrame.new(100, 0, 100),
		})

		planting:Button({
			Text = "Teleport To Offset",
			Callback = function()
				pfunctions.teleport(
					CFrame.new(
						Workspace:FindFirstChild("Map")
							:FindFirstChild("Campground")
							:FindFirstChild("MainFire").PrimaryPart.Position
							+ offset:GetValue().Position
							+ Vector3.new(0, 15, 0)
					)
				)
			end,
		})
	end
end

return init
