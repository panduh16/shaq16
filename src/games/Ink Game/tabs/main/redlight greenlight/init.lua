local functions = require("../../../modules/functions")

function init(ui)
	local rlgl = ui:TreeNode({
		Title = "Redlight Greenlight",
	})
	do
		rlgl:Button({
			Text = "Teleport To End",
			Callback = function()
				functions.teleportTo(CFrame.new(-45.574, 1024.7, 135.325))
			end,
		})
	end
end

return init
