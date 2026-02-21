local functions = require("../../../modules/functions")

function init(ui)
	local glassbridge = ui:TreeNode({
		Title = "Glass Bridge",
	})
	do
		glassbridge:Button({
			Text = "Teleport To End",
			Callback = function()
				functions.teleportTo(CFrame.new(-217, 520, -1534))
			end,
		})

		glassbridge:Button({
			Text = "Mark Tiles",
			Callback = function()
				functions.markTiles()
			end,
		})

		glassbridge:Checkbox({
			Label = "Step On Any Tile",
			Callback = function(self, val)
				functions.markTiles("Step", val)
			end,
		})
	end
end

return init
