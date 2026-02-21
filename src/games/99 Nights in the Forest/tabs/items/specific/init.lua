local functions = require("../../../modules/functions")
local player = game:GetService("Players").LocalPlayer
local pfunctions = require("../../../../../modules/functions")

function init(ui)
	local specific = ui:TreeNode({
		Title = "Specific",
	})
	do
		local function getItemsByName()
			local items = {}

			for _, i in pairs(functions.getItems()) do
				if not table.find(items, i.Name) then
					table.insert(items, i.Name)
				end
			end

			return items
		end

		local selectedItem = specific:Combo({
			Label = "Select Item",
			Selected = getItemsByName()[1],
			GetItems = function()
				return getItemsByName()
			end,
		})

		specific:Button({
			Text = "Teleport To",
			Callback = function()
				for _, i in pairs(functions.getItems()) do
					if i.Name == selectedItem:GetValue() then
						pfunctions.teleport(i.PrimaryPart.CFrame + Vector3.new(0, 5, 0))
					end
				end
			end,
		})

		specific:Button({
			Text = "Bring Singular Item",
			Callback = function()
				local brought = false
				for _, i in pairs(functions.getItems()) do
					if i.Name == selectedItem:GetValue() and brought == false then
						functions.grab(i)
						task.wait(0.01)
						i:PivotTo(pfunctions.getRoot(player).CFrame + Vector3.new(3, 2, 0))
						task.wait(0.01)
						functions.drop(i)
						brought = true
					end
				end
			end,
		})

		specific:Button({
			Text = "Bring ALL of the Item Instances",
			Callback = function()
				for _, i in pairs(functions.getItems()) do
					if i.Name == selectedItem:GetValue() then
						functions.grab(i)
						task.wait(0.01)
						i:PivotTo(pfunctions.getRoot(player).CFrame + Vector3.new(3, 2, 0))
						task.wait(0.01)
						functions.drop(i)
					end
				end
			end,
		})
	end
end

return init
