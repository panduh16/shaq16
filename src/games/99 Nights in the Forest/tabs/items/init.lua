local functions = require("../../modules/functions")
local pfunctions = require("../../../../modules/functions")
local player = game:GetService("Players").LocalPlayer

function init(ui)
	local items = ui:TreeNode({
		Title = "Items",
	})
	do
		items:SetCollapsed(false)

		items:Button({
			Text = "Bring ALL Items To You",
			Callback = function()
				local item = functions.getItems()

				for _, i in pairs(item) do
					functions.grab(i)
					i:PivotTo(pfunctions.getRoot(player).CFrame + Vector3.new(0, 2, 0))
					functions.drop(i)
				end
			end,
		})

		local crafting = require("./crafting")
		crafting(items)

		local burning = require("./burning")
		burning(items)

		local cooking = require("./cooking")
		cooking(items)

		local planting = require("./planting")
		planting(items)

		local specific = require("./specific")
		specific(items)
	end
end

return init
